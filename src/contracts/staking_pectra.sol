// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "interfaces/iface.sol";
import "interfaces/IStaking.sol";
import "solidity-bytes-utils/contracts/BytesLib.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@eigenlayer/contracts/interfaces/IEigenPod.sol";
/**
 * @title Bedrock Ethereum 2.0 Staking Contract V2 Pectra feature
 *
 * Description:
 *
 * ───╔═╦═╗─╔╗╔═╗──────╔╗──╔╗╔╗─╔╦╗╔╗─╔═╗─╔╗───────╔╦╗
 * ╔═╗║═╣═╬═╣╚╣═╣╔══╗╔╗╠╬═╗║╚╬╬╗╠╣╚╬╬═╣═╣╔╝╚╗╔═╦═╦╦╬╣╚╦╦╗
 * ║╬╚╬═╠═║╩╣╔╬═║╠══╣║╚╣║╬╚╣╬║║╚╣║╔╣║╩╬═║╚╗╔╝║╩╣╬║║║║╔╣║║
 * ╚══╩═╩═╩═╩═╩═╝╚══╝╚═╩╩══╩═╩╩═╩╩═╩╩═╩═╝─╚╝─╚═╩╗╠═╩╩═╬╗║
 * ─────────────────────────────────────────────╚╝────╚═╝
 *
 * Term:
 *  ExchangeRatio:              Exchange Ratio of xETH to ETH, normally >= 1.0
 *  TotalXETH:                  Total Supply of xETH
 *  TotalStaked:                Total Ethers Staked to Validators
 *  TotalDebts:                 Total unpaid debts(generated from redeemFromValidators),
 *                              awaiting to be paid by turn off validators to clean debts.
 *  TotalPending:               Pending Ethers(<32 Ethers), awaiting to be staked
 *  RewardDebts:                The amount re-staked into TotalPending
 *
 *  AccountedUserRevenue:       Overall Net revenue which belongs to all xETH holders(excluded re-staked amount)
 *  ReportedValidators:         Latest Reported Validator Count
 *  ReportedValidatorBalance:   Latest Reported Validator Overall Balance
 *  RecentReceived:             The Amount this contract receives recently.
 *  CurrentReserve:             Assets Under Management
 *
 * Lemma 1: (AUM)
 *
 *          CurrentReserve = TotalPending + TotalStaked + AccountedUserRevenue - TotalDebts - RewardDebts
 *
 * Lemma 2: (Exchange Ratio)
 *
 *          ExchangeRatio = CurrentReserve / TotalXETH
 *
 * Rule 1: (function mint) For every mint operation, the ethers pays debt in priority the reset will be put in TotalPending(deprecated),
 *          ethersToMint:               The amount user deposits
 *
 *          TotalPending = TotalPending + ethersToMint
 *          TotalXETH = TotalXETH + ethersToMint / ExchangeRatio
 *
 * Rule 2: (function mint) At any time TotalPending has more than 32 Ethers, It will be staked, TotalPending
 *          moves to TotalStaked and keeps TotalPending less than 32 Ether.
 *
 *          TotalPending = TotalPending - ⌊TotalPending/32ETH⌋ * 32ETH
 *          TotalStaked = TotalStaked + ⌊TotalPending/32ETH⌋ * 32ETH
 *
 * Rule 3: (function validatorStopped) Whenever a validator stopped, all value pays debts in priority, then:
 *          valueStopped:               The value sent-back via receive() funtion
 *          amountUnstaked:             The amount of unstaked node (base 32ethers)
 *          validatorStopped:           The count of validator stopped
 *
 *          incrRewardDebt := valueStopped - amountUnstaked
 *          RewardDebts = RewardDebt + incrRewardDebt
 *          RecentReceived = RecentReceived + valueStopped
 *          TotalPending = TotalPending + Max(0, amountUnstaked - TotalDebts) + incrRewardDebt
 *          TotalStaked = TotalStaked - validatorStopped * 32 ETH
 *
 * Rule 4.1: (function pushBeacon) Oracle push balance, rebase if new validator is alive:
 *          aliveValidator:             The count of validators alive
 *
 *          RewardBase = ReportedValidatorBalance + Max(0, aliveValidator - ReportedValidators) * 32 ETH
 *
 * Rule 4.2: (function pushBeacon) Oracle push balance, revenue calculation:
 *          aliveBalance:               The balance of current alive validators
 *
 *          r := aliveBalance + RecentReceived - RewardBase
 *          AccountedUserRevenue = AccountedUserRevenue + r * (1000 - managerFeeShare) / 1000
 *          RecentReceived = 0
 *          ReportedValidators = aliveValidator
 *          ReportedValidatorBalance = aliveBalance
 */

contract Staking is Initializable, PausableUpgradeable, AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20 for IERC20;
    using Address for address payable;
    using Address for address;

    // stored credentials
    struct ValidatorCredential {
        bytes pubkey;
        bytes signature;
        bool stopped;
        bool restaking;
        uint8 eigenpod;
        uint256 totalStaked;
        uint256 totalDebt;
        // total protocol reward
        uint256 totalReward;
    }

    // track ether debts to return to async caller
    struct Debt {
        address account;
        uint256 amount;
    }

    struct ValidatorDebt {
        bytes pubkey;
        // delta amount, 0 means need stop validator
        uint256 amount;
    }

    struct ValidatorReward {
        bytes pubkey;
        // total reward amount
        uint256 amount;
    }
    /**
     * Incorrect storage preservation:
     *
     *     |Implementation_v0   |Implementation_v1        |
     *     |--------------------|-------------------------|
     *     |address _owner      |address _lastContributor | <=== Storage collision!
     *     |mapping _balances   |address _owner           |
     *     |uint256 _supply     |mapping _balances        |
     *     |...                 |uint256 _supply          |
     *     |                    |...                      |
     *     Correct storage preservation:
     *
     *     |Implementation_v0   |Implementation_v1        |
     *     |--------------------|-------------------------|
     *     |address _owner      |address _owner           |
     *     |mapping _balances   |mapping _balances        |
     *     |uint256 _supply     |uint256 _supply          |
     *     |...                 |address _lastContributor | <=== Storage extension.
     *     |                    |...                      |
     */

    // Always extend storage instead of modifying it
    // Variables in implementation v0
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    bytes32 public constant ORACLE_ROLE = keccak256("ORACLE_ROLE");
    bytes32 public constant REGISTRY_ROLE = keccak256("REGISTRY_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    uint256 public constant DEPOSIT_SIZE = 32 ether;
    uint256 public constant DEPOSIT_PER_VALIDATOR_SIZE = DEPOSIT_SIZE * 52; //1664 ether
    uint256 public constant SAFE_PUSH_REWARDS = 30 ether;
    uint256 private constant MULTIPLIER = 1e18;
    uint256 private constant DEPOSIT_AMOUNT_UNIT = 1000000000 wei;
    uint256 private constant SIGNATURE_LENGTH = 96;
    uint256 private constant PUBKEY_LENGTH = 48;
    address internal constant WITHDRAWAL_REQUEST_ADDRESS = 0x00000961Ef480Eb55e80D19ad83579A64c007002;

    address public ethDepositContract; // ETH 2.0 Deposit contract
    address public xETHAddress; // xETH token address
    address public redeemContract; // redeeming contract for user to pull ethers
    uint256 public managerFeeShare; // manager's fee in 1/1000
    bytes32 public withdrawalCredentials; // WithdrawCredential for all validator
    address public restakingContract;
    address public stakingContractV1;
    // credentials, pushed by owner
    ValidatorCredential[] public validatorRegistry;
    mapping(bytes32 => uint256) private pubkeyIndices; // indices of validatorRegistry by pubkey hash, starts from 1
    // exchange ratio related variables
    // track user deposits & redeem (xETH mint & burn)
    uint256 private totalPending; // track pending ethers awaiting to be staked to validators
    uint256 private totalStaked; // track current staked ethers for validators, rounded to 32 ethers
    uint256 private totalDebts; // track current unpaid debts
    // FIFO of debts from redeemFromValidators
    mapping(uint256 => Debt) private etherDebts;
    uint256 private firstDebt;
    uint256 private lastDebt;
    mapping(address => uint256) private userDebts; // debts from user's perspective
    // track revenue from validators to form exchange ratio
    uint256 private accountedUserRevenue; // accounted shared user revenue
    uint256 private accountedManagerRevenue; // accounted manager's revenue
    uint256 private rewardDebts; // check validatorStopped function
    // revenue related variables
    // track beacon validator & balance
    uint256 private reportedAddedStake;
    uint256 private reportedValidatorBalance;
    uint256 private aliveValidatorBalance;
    // balance tracking
    int256 private accountedBalance; // tracked balance change in functions,
    // NOTE(x): balance might be negative for not accounting validators's redeeming
    uint256 private recentReceived; // track recently received (un-accounted) value into this contract
    bytes32 private vectorClock; // a vector clock for detecting receive() & pushBeacon() causality violations
    uint256 private vectorClockTicks; // record current vector clock step;

    uint256 private reportedUnrealizedProfits;
    /**
     * @dev empty reserved space for future adding of variables
     */
    uint256[31] private __gap;

    /**
     * ======================================================================================
     *
     * SYSTEM SETTINGS, OPERATED VIA OWNER(DAO/TIMELOCK)
     *
     * ======================================================================================
     */
    receive() external payable {}

    constructor() {
        _disableInitializers();
    }

    /**
     * @dev pause the contract
     */
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev unpause the contract
     */
    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @dev initialization address
     */
    function initialize(address _stakingContractV1, address _xETHAddress, address _redeemContract) public initializer {
        __Pausable_init();
        __AccessControl_init();
        __ReentrancyGuard_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ORACLE_ROLE, msg.sender);
        _grantRole(REGISTRY_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MANAGER_ROLE, msg.sender);

        xETHAddress = _xETHAddress;
        redeemContract = _redeemContract;
        // init default values
        managerFeeShare = 100;
        firstDebt = 1;
        lastDebt = 0;
        _vectorClockTick();

        // initiate default withdrawal credential to the contract itself
        // uint8('0x1') + 11 bytes(0) + this.address
        bytes memory cred = abi.encodePacked(bytes1(0x02), new bytes(11), address(this));
        withdrawalCredentials = BytesLib.toBytes32(cred, 0);

        stakingContractV1 = _stakingContractV1;
    }

    /**
     * @dev replace validators in batch
     */
    function replaceValidators(
        bytes[] calldata oldpubkeys,
        bytes[] calldata pubkeys,
        bytes[] calldata signatures,
        bool restaking,
        uint8[] calldata podIds
    ) external onlyRole(REGISTRY_ROLE) {
        _require(pubkeys.length == signatures.length, "SYS007");
        _require(oldpubkeys.length == pubkeys.length, "SYS007");
        _require(pubkeys.length == podIds.length, "SYS007");

        uint256 n = pubkeys.length;

        for (uint256 i = 0; i < n; i++) {
            _require(oldpubkeys[i].length == PUBKEY_LENGTH, "SYS004");
            _require(pubkeys[i].length == PUBKEY_LENGTH, "SYS004");
            _require(signatures[i].length == SIGNATURE_LENGTH, "SYS003");

            // mark old pub key to false
            bytes32 oldPubKeyHash = keccak256(oldpubkeys[i]);
            _require(pubkeyIndices[oldPubKeyHash] > 0, "SYS006");
            uint256 index = pubkeyIndices[oldPubKeyHash] - 1;
            delete pubkeyIndices[oldPubKeyHash];

            // set new pubkey
            bytes32 pubkeyHash = keccak256(pubkeys[i]);
            ValidatorCredential storage validator = validatorRegistry[index];
            validator.pubkey = pubkeys[i];
            validator.signature = signatures[i];
            validator.restaking = restaking;
            validator.eigenpod = podIds[i];
            pubkeyIndices[pubkeyHash] = index + 1;
        }
    }

    /**
     * @dev register a batch of LRT validators
     */
    function registerRestakingValidators(bytes[] calldata pubkeys, bytes[] calldata signatures, uint8[] calldata podIds)
        external
        onlyRole(REGISTRY_ROLE)
    {
        _require(pubkeys.length == signatures.length, "SYS007");
        _require(pubkeys.length == podIds.length, "SYS007");
        uint256 n = pubkeys.length;
        uint256 maxPods = IRestaking(restakingContract).getTotalPods();

        for (uint256 i = 0; i < n; i++) {
            _require(pubkeys[i].length == PUBKEY_LENGTH, "SYS004");
            _require(signatures[i].length == SIGNATURE_LENGTH, "SYS003");
            _require(podIds[i] < maxPods, "SYS031");

            bytes32 pubkeyHash = keccak256(pubkeys[i]);
            _require(pubkeyIndices[pubkeyHash] == 0, "SYS005");
            validatorRegistry.push(
                ValidatorCredential({
                    pubkey: pubkeys[i],
                    signature: signatures[i],
                    stopped: false,
                    restaking: true,
                    eigenpod: podIds[i],
                    totalStaked: 0,
                    totalDebt: 0,
                    totalReward: 0
                })
            );
            pubkeyIndices[pubkeyHash] = validatorRegistry.length;
        }
    }

    function registerStakingValidators(bytes[] calldata pubkeys, bytes[] calldata signatures)
        external
        onlyRole(REGISTRY_ROLE)
    {
        _require(pubkeys.length == signatures.length, "SYS007");
        uint256 n = pubkeys.length;

        for (uint256 i = 0; i < n; i++) {
            _require(pubkeys[i].length == PUBKEY_LENGTH, "SYS004");
            _require(signatures[i].length == SIGNATURE_LENGTH, "SYS003");

            bytes32 pubkeyHash = keccak256(pubkeys[i]);
            _require(pubkeyIndices[pubkeyHash] == 0, "SYS005");
            validatorRegistry.push(
                ValidatorCredential({
                    pubkey: pubkeys[i],
                    signature: signatures[i],
                    stopped: false,
                    restaking: false,
                    eigenpod: 0,
                    totalStaked: 0,
                    totalDebt: 0,
                    totalReward: 0
                })
            );
            pubkeyIndices[pubkeyHash] = validatorRegistry.length;
        }
    }
    /**
     * @dev set manager's fee in 1/1000
     */

    function setManagerFeeShare(uint256 milli) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _require(milli >= 0 && milli <= 1000, "SYS008");
        managerFeeShare = milli;

        emit ManagerFeeSet(milli);
    }

    /**
     * @dev set eth deposit contract address
     */
    function setETHDepositContract(address _ethDepositContract) external onlyRole(DEFAULT_ADMIN_ROLE) {
        ethDepositContract = _ethDepositContract;

        emit DepositContractSet(_ethDepositContract);
    }

    /**
     * @dev set restaking contract address
     */
    function setRestakingContract(address _restakingContract) external onlyRole(DEFAULT_ADMIN_ROLE) {
        restakingContract = _restakingContract;

        emit RestakingAddressSet(_restakingContract);
    }

    /**
     * @dev set withdraw credential to receive revenue, usually this should be the contract itself.
     */
    function setWithdrawCredential(bytes32 withdrawalCredentials_) external onlyRole(DEFAULT_ADMIN_ROLE) {
        withdrawalCredentials = withdrawalCredentials_;
        emit WithdrawCredentialSet(withdrawalCredentials);
    }

    /**
     * @dev stake into eth2 staking contract by calling this function
     */
    function stake() external {
        _stakeInternal();
    }

    /**
     * @dev internal entry of stake() external
     */
    function _stakeInternal() internal {
        if (totalPending / DEPOSIT_SIZE == 0) {
            return;
        }
        for (uint256 i = 0; i < validatorRegistry.length; i++) {
            ValidatorCredential storage cred = validatorRegistry[i];
            if (cred.stopped) {
                continue;
            }
            // check if we can stake on this validator
            uint256 staked = cred.totalStaked + cred.totalReward - cred.totalDebt;
            while (staked < DEPOSIT_PER_VALIDATOR_SIZE && totalPending / DEPOSIT_SIZE > 0) {
                if (!cred.restaking) {
                    _stake(cred.pubkey, cred.signature, withdrawalCredentials);
                } else {
                    address eigenPod = IRestaking(restakingContract).getPod(cred.eigenpod);
                    bytes memory eigenPodCred = abi.encodePacked(bytes1(0x02), new bytes(11), eigenPod);
                    bytes32 restakingWithdrawalCredentials = BytesLib.toBytes32(eigenPodCred, 0);

                    _stake(cred.pubkey, cred.signature, restakingWithdrawalCredentials);
                }

                // track total staked & total pending ethers
                totalStaked += DEPOSIT_SIZE;
                reportedAddedStake += DEPOSIT_SIZE;
                totalPending -= DEPOSIT_SIZE;
                cred.totalStaked += DEPOSIT_SIZE;
                staked = cred.totalStaked + cred.totalReward - cred.totalDebt;
            }
            emit ValidatorStaked(i, staked);
        }
    }

    /**
     * @dev manager withdraw fees as uniETH
     */
    function withdrawManagerFee(address to) external onlyRole(MANAGER_ROLE) {
        IERC20(xETHAddress).safeTransfer(to, IERC20(xETHAddress).balanceOf(address(this)));
    }

    /**
     * @dev compound manager's revenue
     *  NOTE(20240406): this MUST be called in pushBeacon, to make sure debts are paied in priority, otherwise
     *      debts may be used to pay as the manager's revenue(that may take serveral months to come back).
     */
    function _compoundManagerRevenue() internal {
        uint256 freeEthers = address(this).balance - totalPending;
        uint256 amountEthers = freeEthers < accountedManagerRevenue ? freeEthers : accountedManagerRevenue;

        if (amountEthers > 0) {
            uint256 totalSupply = IERC20(xETHAddress).totalSupply();
            uint256 totalEthers = currentReserve();
            uint256 tokensToMint = totalSupply * amountEthers / totalEthers;

            // swapping
            // uint256 ratio = _exchangeRatioInternal();           // RATIO GUARD BEGIN
            IMintableContract(xETHAddress).mint(address(this), tokensToMint);
            totalPending += amountEthers;
            accountedManagerRevenue -= amountEthers;
            // assert(ratio == _exchangeRatioInternal());          // RATIO GUARD END

            emit ManagerRevenueCompounded(amountEthers);
        }
    }

    /**
     * @dev clear debts
     */
    function _clearDebts() internal {
        uint256 maxUsable = (address(this).balance - totalPending) / DEPOSIT_SIZE * DEPOSIT_SIZE;
        uint256 effectiveEthers = totalDebts < maxUsable ? totalDebts : maxUsable;

        if (effectiveEthers > 0) {
            uint256 ratio = _exchangeRatioInternal(); // RATIO GUARD BEGIN

            uint256 paid = _payDebts(effectiveEthers);
            totalStaked -= paid;
            emit Cleared(effectiveEthers);

            assert(ratio == _exchangeRatioInternal()); // RATIO GUARD END
        }
    }

    /**
     * @dev balance sync, also moves the vector clock if it has different value
     */
    function syncBalance() external {
        _syncBalance();
    }

    /**
     * @dev balance sync, also moves the vector clock if it has different value
     */
    function _syncBalance() internal {
        // account restaking values
        IRestaking(restakingContract).update();

        assert(SafeCast.toInt256(address(this).balance) >= accountedBalance);
        uint256 diff = SafeCast.toUint256(SafeCast.toInt256(address(this).balance) - accountedBalance);
        if (diff > 0) {
            accountedBalance = SafeCast.toInt256(address(this).balance);
            recentReceived += diff;
            _vectorClockTick();
            emit BalanceSynced(diff);
        }
    }

    /**
     * @dev public invokable settlement to update exchangeRatio with default revenue limit.
     */
    function pushBeacon() external {
        _pushBeacon(vectorClock, SAFE_PUSH_REWARDS);
    }

    /**
     * @dev operators to settle revenue with custom revenue limit under abnormal conditions.
     */
    function pushBeacon(bytes32 clock, uint256 maxRewards) external onlyRole(ORACLE_ROLE) {
        _pushBeacon(clock, maxRewards);
    }

    function _pushBeacon(bytes32 clock, uint256 maxRewards) internal {
        _require(vectorClock == clock, "SYS012");

        // Collect new revenue if there is any.
        _syncBalance();

        // Check if new validators increased
        // and adjust rewardBase to include the new validators' value
        uint256 rewardBase = reportedValidatorBalance + reportedUnrealizedProfits;
        uint256 _unrealizedProfits = IRestaking(restakingContract).getPendingWithdrawalAmount(); // get unrealized profits
        uint256 _totalEther = aliveValidatorBalance + _unrealizedProfits + recentReceived;
        if (reportedAddedStake > 0) {
            // make sure addedStake really goes to validator balance.
            uint256 _num = (_totalEther - rewardBase) / DEPOSIT_SIZE;
            if (_num > 0) {
                rewardBase = reportedAddedStake > _num * DEPOSIT_SIZE
                    ? rewardBase + _num * DEPOSIT_SIZE
                    : rewardBase + reportedAddedStake;

                reportedAddedStake =
                    reportedAddedStake > _num * DEPOSIT_SIZE ? reportedAddedStake - _num * DEPOSIT_SIZE : 0;
            }
        }

        // Rewards calculation, this also considers recentReceived ethers from
        // either stopped validators or withdrawed ethers as rewards.
        //
        // During two consecutive pushBeacon operation, the ethers will ONLY:
        //  1. staked to new validators
        //  2. move from active validators to this contract
        //
        // so, at any time, revenue generated if:
        //
        //  current active validator balance
        //      + recent received from validators(since last pushBeacon)
        //  >（GREATER THAN) reward base(last active validator balance + new nodes balance)

        _require(_totalEther >= rewardBase, "SYS015");
        uint256 rewards = _totalEther - rewardBase;
        _require(rewards <= maxRewards, "SYS016");

        _distributeRewards(rewards);

        // PRIORITY IN ETHER USAGE:
        // 1. to clear off debts
        // 2. to compound manager's revenue
        // 3. to auto-compound
        _clearDebts();
        _compoundManagerRevenue();
        _autocompound();

        // Update reportedValidators & reportedValidatorBalance
        // reset the recentReceived to 0
        reportedValidatorBalance = aliveValidatorBalance;
        reportedUnrealizedProfits = _unrealizedProfits;
        recentReceived = 0;
    }

    function retryWithdrawal(ValidatorDebt[] calldata _validatorDebts, bytes32 clock)
        external
        payable
        nonReentrant
        onlyRole(ORACLE_ROLE)
    {
        _require(vectorClock == clock, "SYS012");
        uint256 oneRequestFee = _getFee(WITHDRAWAL_REQUEST_ADDRESS);
        uint256 totalFee = oneRequestFee * _validatorDebts.length;
        uint256 remainder = msg.value - totalFee;
        _require(msg.value >= totalFee, "USE007");
        for (uint256 i = 0; i < _validatorDebts.length; i++) {
            uint256 index = pubkeyIndices[keccak256(_validatorDebts[i].pubkey)] - 1;
            ValidatorCredential memory validator = validatorRegistry[index];
            //do withdraw
            if (validator.restaking) {
                _requestWithdrawal(
                    validator.eigenpod,
                    validator.pubkey,
                    uint64(_validatorDebts[i].amount / DEPOSIT_AMOUNT_UNIT),
                    oneRequestFee
                );
            } else {
                _requestWithdrawal(
                    validator.pubkey, uint64(_validatorDebts[i].amount / DEPOSIT_AMOUNT_UNIT), oneRequestFee
                );
            }
        }
        // Refund remainder of msg.value
        if (remainder > 0) {
            Address.sendValue(payable(msg.sender), remainder);
        }
        // vector clock moves
        _vectorClockTick();
    }

    function pushValidatorDebts(ValidatorDebt[] calldata _validatorDebts, bytes32 clock)
        external
        payable
        nonReentrant
        onlyRole(ORACLE_ROLE)
    {
        _require(vectorClock == clock, "SYS012");
        uint256 oneRequestFee = _getFee(WITHDRAWAL_REQUEST_ADDRESS);
        uint256 totalFee = oneRequestFee * _validatorDebts.length;
        _require(msg.value >= totalFee, "USE007");
        uint256 remainder = msg.value - totalFee;
        for (uint256 i = 0; i < _validatorDebts.length; i++) {
            uint256 index = pubkeyIndices[keccak256(_validatorDebts[i].pubkey)] - 1;
            ValidatorCredential storage validator = validatorRegistry[index];
            validator.totalDebt += _validatorDebts[i].amount;
            _require(!validator.stopped, "SYS013");
            //do withdraw
            if (_validatorDebts[i].amount == 0) {
                validator.stopped = true;
            }
            if (validator.restaking) {
                _requestWithdrawal(
                    validator.eigenpod,
                    validator.pubkey,
                    uint64(_validatorDebts[i].amount / DEPOSIT_AMOUNT_UNIT),
                    oneRequestFee
                );
            } else {
                _requestWithdrawal(
                    validator.pubkey, uint64(_validatorDebts[i].amount / DEPOSIT_AMOUNT_UNIT), oneRequestFee
                );
            }
            emit ValidatorWithdraw(index, _validatorDebts[i].amount / DEPOSIT_AMOUNT_UNIT);
        }
        // Refund remainder of msg.value
        if (remainder > 0) {
            Address.sendValue(payable(msg.sender), remainder);
        }
        // vector clock moves
        _vectorClockTick();
    }

    function pushValidators(
        uint256 _totalAliveBalance,
        bool _callPushBeacon,
        bytes32 clock,
        ValidatorReward[] calldata _validatorRewards
    ) external nonReentrant onlyRole(ORACLE_ROLE) {
        aliveValidatorBalance = _totalAliveBalance;

        for (uint256 i = 0; i < _validatorRewards.length; i++) {
            uint256 index = pubkeyIndices[keccak256(_validatorRewards[i].pubkey)] - 1;
            ValidatorCredential storage validator = validatorRegistry[index];
            validator.totalReward = _validatorRewards[i].amount;
        }

        if (_callPushBeacon) {
            // vector clock moves in _pushBeacon
            _pushBeacon(clock, SAFE_PUSH_REWARDS);
            return;
        }
        _require(vectorClock == clock, "SYS012");
        // vector clock moves
        _vectorClockTick();
    }

    /**
     * ======================================================================================
     *
     * VIEW FUNCTIONS
     *
     * ======================================================================================
     */

    /**
     * @dev returns current reserve of ethers
     */
    function currentReserve() public view returns (uint256) {
        return currentReserveV2() + IStaking(stakingContractV1).currentReserveV1();
    }

    function currentReserveV2() public view returns (uint256) {
        return totalPending + totalStaked + accountedUserRevenue - totalDebts - rewardDebts;
    }

    function _getFee(address predeploy) internal view returns (uint256) {
        (bool success, bytes memory result) = predeploy.staticcall("");
        _require(success && result.length == 32, "SYS021");

        return uint256(bytes32(result));
    }

    function getWithdrawalFee() external view returns (uint256) {
        return _getFee(WITHDRAWAL_REQUEST_ADDRESS);
    }

    /*
     * @dev returns current vector clock
     */

    function getVectorClock() external view returns (bytes32) {
        return vectorClock;
    }

    /*
     * @dev returns current accounted balance
     */
    function getAccountedBalance() external view returns (int256) {
        return accountedBalance;
    }

    /**
     * @dev return total staked ethers
     */
    function getTotalStaked() external view returns (uint256) {
        return totalStaked;
    }

    /**
     * @dev return pending ethers
     */
    function getPendingEthers() external view returns (uint256) {
        return totalPending;
    }

    /**
     * @dev return reward debts(total compounded ethers)
     */
    function getRewardDebts() external view returns (uint256) {
        return rewardDebts;
    }

    /**
     * @dev return current debts
     */
    function getCurrentDebts() external view returns (uint256) {
        return totalDebts;
    }

    /**
     * @dev returns the accounted user revenue
     */
    function getAccountedUserRevenue() external view returns (uint256) {
        return accountedUserRevenue;
    }

    /**
     * @dev returns the accounted manager's revenue
     */
    function getAccountedManagerRevenue() external view returns (uint256) {
        return accountedManagerRevenue;
    }

    /**
     * @dev returns the reported unrealized profits
     */
    function getReportedUnrealizedProfits() external view returns (uint256) {
        return reportedUnrealizedProfits;
    }

    /*
     * @dev returns accumulated beacon validators
     */
    function getReportedAddedStake() external view returns (uint256) {
        return reportedAddedStake;
    }

    /*
     * @dev returns reported validator balance snapshot
     */
    function getReportedValidatorBalance() external view returns (uint256) {
        return reportedValidatorBalance;
    }

    /**
     * @dev returns the alive validator balance
     */
    function getAliveValidatorBalance() external view returns (uint256) {
        return aliveValidatorBalance;
    }

    /*
     * @dev returns recent received value
     */
    function getRecentReceived() external view returns (uint256) {
        return recentReceived;
    }

    /**
     * @dev return debt for an account
     */
    function debtOf(address account) external view returns (uint256) {
        return userDebts[account];
    }

    /**
     * @dev return number of registered validator
     */
    function getRegisteredValidatorsCount() external view returns (uint256) {
        return validatorRegistry.length;
    }

    /**
     * @dev return a batch of validators information
     * UPDATE(20240119): V2 returns restaking info
     */
    function getRegisteredValidators(uint256 idx_from, uint256 idx_to)
        external
        view
        returns (
            bytes[] memory _pubkeys,
            bytes[] memory _signatures,
            bool[] memory _stopped,
            bool[] memory _restaking,
            uint256[] memory _totalStaked,
            uint256[] memory _totalDebt,
            uint256[] memory _totalReward
        )
    {
        _pubkeys = new bytes[](idx_to - idx_from);
        _signatures = new bytes[](idx_to - idx_from);
        _stopped = new bool[](idx_to - idx_from);
        _restaking = new bool[](idx_to - idx_from);
        _totalStaked = new uint256[](idx_to - idx_from);
        _totalDebt = new uint256[](idx_to - idx_from);
        _totalReward = new uint256[](idx_to - idx_from);

        uint256 counter = 0;
        for (uint256 i = idx_from; i < idx_to; i++) {
            _pubkeys[counter] = validatorRegistry[i].pubkey;
            _signatures[counter] = validatorRegistry[i].signature;
            _stopped[counter] = validatorRegistry[i].stopped;
            _restaking[counter] = validatorRegistry[i].restaking;
            _totalStaked[counter] = validatorRegistry[i].totalStaked;
            _totalDebt[counter] = validatorRegistry[i].totalDebt;
            _totalReward[counter] = validatorRegistry[i].totalReward;
            counter++;
        }
    }

    /**
     * @dev return exchange ratio for 1 uniETH to ETH, multiplied by 1e18
     */
    function exchangeRatio() external view returns (uint256) {
        return _exchangeRatioInternal();
    }

    function _exchangeRatioInternal() internal view returns (uint256) {
        uint256 xETHAmount = IERC20(xETHAddress).totalSupply();
        if (xETHAmount == 0) {
            return 1 * MULTIPLIER;
        }

        uint256 ratio = currentReserve() * MULTIPLIER / xETHAmount;
        return ratio;
    }

    /**
     * @dev return debt of index
     */
    function checkDebt(uint256 index) external view returns (address account, uint256 amount) {
        Debt memory debt = etherDebts[index];
        return (debt.account, debt.amount);
    }
    /**
     * @dev return debt queue index
     */

    function getDebtQueue() external view returns (uint256 first, uint256 last) {
        return (firstDebt, lastDebt);
    }

    /**
     * ======================================================================================
     *
     * EXTERNAL FUNCTIONS
     *
     * ======================================================================================
     */
    /**
     * @dev mint xETH with ETH
     */
    function mint(uint256 minToMint, uint256 deadline)
        external
        payable
        nonReentrant
        whenNotPaused
        returns (uint256 minted)
    {
        _require(block.timestamp < deadline, "USR001");
        _require(msg.value > 0, "USR002");

        // track balance
        _balanceIncrease(msg.value);

        // mint xETH while keeping the exchange ratio invariant
        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 totalEthers = currentReserve();
        uint256 toMint = 1 * msg.value; // default exchange ratio 1:1

        if (totalEthers > 0) {
            // avert division overflow
            toMint = totalXETH * msg.value / totalEthers;
        }

        _require(toMint >= minToMint, "USR004");

        // mint token while keeping exchange ratio invariant
        // uint256 ratio = _exchangeRatioInternal();           // RATIO GUARD BEGIN
        IMintableContract(xETHAddress).mint(msg.sender, toMint);
        totalPending += msg.value;
        // assert(ratio == _exchangeRatioInternal());          // RATIO GUARD END

        // try to initiate stake()
        _stakeInternal();

        return toMint;
    }

    function _requestWithdrawal(uint8 eigenPod, bytes memory pubkey, uint64 amountGwei, uint256 fee) internal {
        IEigenPodTypes.WithdrawalRequest memory req =
            IEigenPodTypes.WithdrawalRequest({pubkey: pubkey, amountGwei: amountGwei});
        IEigenPodTypes.WithdrawalRequest[] memory reqs = new IEigenPodTypes.WithdrawalRequest[](1);
        reqs[0] = req;
        IRestaking(restakingContract).requestWithdrawal{value: fee}(eigenPod, reqs);
    }

    function _requestWithdrawal(bytes memory pubkey, uint64 amountGwei, uint256 fee) internal {
        // Call the predeploy
        bytes memory callData = abi.encodePacked(pubkey, amountGwei);
        (bool ok,) = WITHDRAWAL_REQUEST_ADDRESS.call{value: fee}(callData);
        _require(ok, "SYS034");
    }

    /**
     * @dev redeem N * 32Ethers, which will turn off validadators,
     * note this function is asynchronous, the caller will only receive his ethers
     * after the validator has turned off.
     *
     * this function is dedicated for institutional operations.
     *
     * redeem keeps the ratio invariant
     */
    function redeemFromValidators(uint256 ethersToRedeem, uint256 maxToBurn, uint256 deadline)
        external
        nonReentrant
        returns (uint256 burned)
    {
        _require(block.timestamp < deadline, "USR001");
        _require(ethersToRedeem % DEPOSIT_SIZE == 0, "USR005");
        _require(ethersToRedeem > 0, "USR005");

        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 xETHToBurn = totalXETH * ethersToRedeem / currentReserve();
        _require(xETHToBurn <= maxToBurn, "USR004");

        // NOTE: the following procdure must keep exchangeRatio invariant:
        // transfer xETH from sender & burn
        // uint256 ratio = _exchangeRatioInternal();           // RATIO GUARD BEGIN
        IMintableContract(xETHAddress).burnFrom(msg.sender, xETHToBurn);
        _enqueueDebt(msg.sender, ethersToRedeem); // queue ether debts
        // assert(ratio == _exchangeRatioInternal());          // RATIO GUARD END

        // return burned
        return xETHToBurn;
    }

    /**
     * ======================================================================================
     *
     * INTERNAL FUNCTIONS
     *
     * ======================================================================================
     */
    function _balanceIncrease(uint256 amount) internal {
        accountedBalance += SafeCast.toInt256(amount);
    }

    function _balanceDecrease(uint256 amount) internal {
        accountedBalance -= SafeCast.toInt256(amount);
    }

    function _vectorClockTick() internal {
        vectorClockTicks++;
        vectorClock = keccak256(abi.encodePacked(vectorClock, block.timestamp, vectorClockTicks));
    }

    function _enqueueDebt(address account, uint256 amount) internal {
        // debt is paid in FIFO queue
        lastDebt += 1;
        etherDebts[lastDebt] = Debt({account: account, amount: amount});

        // track user debts
        userDebts[account] += amount;
        // track total debts
        totalDebts += amount;

        // log
        emit DebtQueued(account, amount);
    }

    function _dequeueDebt() internal returns (Debt memory debt) {
        _require(lastDebt >= firstDebt, "SYS022"); // non-empty queue
        debt = etherDebts[firstDebt];
        delete etherDebts[firstDebt];
        firstDebt += 1;
    }

    /**
     * @dev pay debts for a given amount
     */
    function _payDebts(uint256 total) internal returns (uint256 amountPaid) {
        // ethers to pay
        for (uint256 i = firstDebt; i <= lastDebt; i++) {
            if (total == 0) {
                break;
            }

            Debt storage debt = etherDebts[i];

            // clean debts
            uint256 toPay = debt.amount <= total ? debt.amount : total;
            debt.amount -= toPay;
            total -= toPay;
            userDebts[debt.account] -= toPay;
            amountPaid += toPay;

            // transfer money to debt contract
            IRedeem(redeemContract).pay{value: toPay}(debt.account);

            // dequeue if cleared
            if (debt.amount == 0) {
                _dequeueDebt();
            }
        }

        totalDebts -= amountPaid;

        // track balance
        _balanceDecrease(amountPaid);
    }

    /**
     * @dev distribute revenue
     */
    function _distributeRewards(uint256 rewards) internal {
        // rewards distribution
        uint256 fee = rewards * managerFeeShare / 1000;
        accountedManagerRevenue += fee;
        accountedUserRevenue += rewards - fee;

        emit RevenueAccounted(rewards);
    }

    /**
     * @dev auto compounding, after shanghai merge, called in pushBeacon
     *  NOTE(20240406): this MUST be called in pushBeacon, to make sure debts are paied in priority, otherwise
     *      debts may be used to pay as the users' revenue(that may take serveral months to come back).
     */
    function _autocompound() internal {
        uint256 maxCompound = accountedUserRevenue - rewardDebts;
        uint256 maxUsable = address(this).balance - totalPending;
        uint256 effectiveEthers = maxCompound < maxUsable ? maxCompound : maxUsable;

        if (effectiveEthers > 0) {
            totalPending += effectiveEthers;
            rewardDebts += effectiveEthers;
            emit UserRevenueCompounded(effectiveEthers);
        }
    }

    /**
     * @dev Invokes a deposit call to the official Deposit contract
     *      UPDATE(20240115): add param withCred, instead of using contract variable
     */
    function _stake(bytes memory pubkey, bytes memory signature, bytes32 withCred) internal {
        _require(withCred != bytes32(0x0), "SYS024");
        uint256 value = DEPOSIT_SIZE;
        uint256 depositAmount = DEPOSIT_SIZE / DEPOSIT_AMOUNT_UNIT;
        assert(depositAmount * DEPOSIT_AMOUNT_UNIT == value); // properly rounded

        // Compute deposit data root (`DepositData` hash tree root)
        // https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa#code
        bytes32 pubkey_root = sha256(abi.encodePacked(pubkey, bytes16(0)));
        bytes32 signature_root = sha256(
            abi.encodePacked(
                sha256(BytesLib.slice(signature, 0, 64)),
                sha256(abi.encodePacked(BytesLib.slice(signature, 64, SIGNATURE_LENGTH - 64), bytes32(0)))
            )
        );

        bytes memory amount = to_little_endian_64(uint64(depositAmount));

        bytes32 depositDataRoot = sha256(
            abi.encodePacked(
                sha256(abi.encodePacked(pubkey_root, withCred)),
                sha256(abi.encodePacked(amount, bytes24(0), signature_root))
            )
        );

        IDepositContract(ethDepositContract).deposit{value: DEPOSIT_SIZE}(
            pubkey, abi.encodePacked(withCred), signature, depositDataRoot
        );

        // track balance
        _balanceDecrease(DEPOSIT_SIZE);
    }

    /**
     * @dev to little endian
     * https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa#code
     */
    function to_little_endian_64(uint64 value) internal pure returns (bytes memory ret) {
        ret = new bytes(8);
        bytes8 bytesValue = bytes8(value);
        // Byteswapping during copying to bytes.
        ret[0] = bytesValue[7];
        ret[1] = bytesValue[6];
        ret[2] = bytesValue[5];
        ret[3] = bytesValue[4];
        ret[4] = bytesValue[3];
        ret[5] = bytesValue[2];
        ret[6] = bytesValue[1];
        ret[7] = bytesValue[0];
    }

    /**
     * @dev function version of _require, which could make the code size smaller
     */
    function _require(bool condition, string memory text) private pure {
        require(condition, text);
    }

    /**
     * ======================================================================================
     *
     * CONTRCT EVENTS
     *
     * ======================================================================================
     */
    event RevenueAccounted(uint256 amount);
    event ManagerFeeSet(uint256 milli);
    event WithdrawCredentialSet(bytes32 withdrawCredential);
    event RestakingAddressSet(address addr);
    event DebtQueued(address creditor, uint256 amountEther);
    event DepositContractSet(address addr);
    event BalanceSynced(uint256 diff);
    event ManagerRevenueCompounded(uint256 amount);
    event UserRevenueCompounded(uint256 amount);
    event Cleared(uint256 amount);
    event ValidatorStaked(uint256 validatorId, uint256 amount);
    event ValidatorWithdraw(uint256 validatorId, uint256 amount);
}
