// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "interfaces/iface.sol";
import "@eigenlayer/contracts/interfaces/IEigenPodManager.sol";
import "@eigenlayer/contracts/interfaces/IEigenPod.sol";
import "@eigenlayer/contracts/libraries/BeaconChainProofs.sol";

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

contract PodOwner is IPodOwner, Initializable, OwnableUpgradeable {
    using Address for address;
    using Address for address payable;
    
    receive() external payable { }
    constructor() { _disableInitializers(); }

    function initialize(address _eigenPodManager) initializer public {
        __Ownable_init();

        IEigenPodManager(_eigenPodManager).createPod();
    }

    function execute(address target, bytes memory data) override onlyOwner external returns(bytes memory) {
        return target.functionCall(data);
    }

    function transfer(address target, uint256 amount) onlyOwner external {
        payable(target).sendValue(amount);
    }

}

/**
 * @title Bedrock EigenLayer Restaking Contract
 *
 * Description:
 *  This contract manages restaking on eigenlayer, including:
 *      1. createPod for native staking
 *      2. withdraws rewards from eigenpod to staking contract.
 */
contract Restaking is Initializable, AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    using Address for address;
    using Address for address payable;

    bytes32 public constant OPERATOR_ROLE= keccak256("OPERATOR_ROLE");

    /// @dev the EigenLayer EigenPodManager contract
    address public eigenPodManager;
    /// @dev The EigenPod owned by this contract
    address public eigenPod;
    /// @dev the DelegationManager contract
    address public delegationManager;
    /// @dev the StrategyManager contract
    address public strategyManager;
    /// @dev the DelayedWithdrawalRouter contract
    address public _DEPRECATED_delayedWithdrawalRouter;
    /// @dev record pending withdrawal amount from EigenPod to DelayedWithdrawalRouter 
    uint256 private _DEPRECATED_pendingWithdrawal;
    // @dev staking contract address
    address public stakingAddress;

    // @dev PodOwner upgradable beacon
    UpgradeableBeacon public beacon;

    // @dev pods owners
    IPodOwner [] public podOwners;

    // @dev onlySelf requirement
    modifier onlySelf() {
       if (msg.sender != address(this))
            revert();
        _;
    }

    /**
     * @dev forward to staking contract
     */
    receive() external payable { }
    constructor() { _disableInitializers(); }

    /**
     * @dev initialization 
     */
    /*
    function initialize(
        address _eigenPodManager,
        address _delegationManager,
        address _strategyManager,
        address _delayedWithdrawalRouter
    ) initializer public {
        require(_eigenPodManager != address(0x0), "SYS026");
        require(_delegationManager!= address(0x0), "SYS027");
        require(_strategyManager!= address(0x0), "SYS028");
        require(_delayedWithdrawalRouter!= address(0x0), "SYS029");

        __AccessControl_init();
        __ReentrancyGuard_init();

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(OPERATOR_ROLE, msg.sender);

        // Assign to local variable
        eigenPodManager = _eigenPodManager;
        delegationManager = _delegationManager;
        strategyManager = _strategyManager;
        delayedWithdrawalRouter = _delayedWithdrawalRouter;

        // Deploy new EigenPod
        IEigenPodManager(eigenPodManager).createPod();

        // Save off the EigenPod address
        eigenPod = address(IEigenPodManager(eigenPodManager).getPod(address(this)));
    }
   */

    /**
     * @dev UPDATE(20240130): to set a variable after upgrades
     * use upgradeAndCall to initializeV2
     */ 
     /*
    function initializeV2(address stakingAddress_) reinitializer(2) public {
        stakingAddress = stakingAddress_;
    }
   */

    /**
     * @dev UPDATE(20240330): to init upgradable beacon/beaconproxy
     */
    function initializeV3(address impl) reinitializer(3) public {
        beacon = new UpgradeableBeacon(impl);
        podOwners.push(IPodOwner(address(this)));
    }

    /**
     * @dev upgradeBeacon
     */
    function upgradeBeacon(address impl) onlyRole(DEFAULT_ADMIN_ROLE) external {
        beacon.upgradeTo(impl);
    }

    /**
     * @dev call delegation operations
     */
    function callDelegationManager(uint256 podId, bytes memory data) external onlyRole(OPERATOR_ROLE) returns(bytes memory) {
        IPodOwner podOwner = podOwners[podId];
        return podOwner.execute(delegationManager, data); // execute delegation operations
    }

    /**
     * @notice This function verifies that the withdrawal credentials of validator(s) owned by the podOwner are pointed to
     * this contract. It also verifies the effective balance  of the validator.  It verifies the provided proof of the ETH validator against the beacon chain state
     * root, marks the validator as 'active' in EigenLayer, and credits the restaked ETH in Eigenlayer.
     * @param oracleTimestamp is the Beacon Chain timestamp whose state root the `proof` will be proven against.
     * @param stateRootProof proves a `beaconStateRoot` against a block root fetched from the oracle
     * @param validatorIndices is the list of indices of the validators being proven, refer to consensus specs
     * @param validatorFieldsProofs proofs against the `beaconStateRoot` for each validator in `validatorFields`
     * @param validatorFields are the fields of the "Validator Container", refer to consensus specs
     * for details: https://github.com/ethereum/consensus-specs/blob/dev/specs/phase0/beacon-chain.md#validator
     */
    function verifyWithdrawalCredentials(
        uint256 podId,
        uint64 oracleTimestamp,
        BeaconChainProofs.StateRootProof calldata stateRootProof,
        uint40[] calldata validatorIndices,
        bytes[] calldata validatorFieldsProofs,
        bytes32[][] calldata validatorFields
    ) external onlyRole(OPERATOR_ROLE) {
        IPodOwner podOwner = podOwners[podId];
        address pod = address(IEigenPodManager(eigenPodManager).getPod(address(podOwner)));

        bytes memory data = abi.encodeWithSelector(IEigenPod.verifyWithdrawalCredentials.selector,
                                                   oracleTimestamp, 
                                                   stateRootProof, 
                                                   validatorIndices, 
                                                   validatorFieldsProofs, 
                                                   validatorFields);

        podOwner.execute(pod, data);
    }

    /**
     * @dev start checkpoint
     * @param podId the pod id
     * @param revertIfNoBalance revert if no balance
     */
    function startCheckPoint(uint256 podId, bool revertIfNoBalance) external onlyRole(OPERATOR_ROLE) {
        IPodOwner podOwner = podOwners[podId];
        address pod = address(IEigenPodManager(eigenPodManager).getPod(address(podOwner)));

        podOwner.execute(pod, abi.encodeWithSelector(IEigenPod.startCheckpoint.selector, revertIfNoBalance));
    }

    /**
     * @dev create pod
     */ 
    function createPod() external onlyRole(DEFAULT_ADMIN_ROLE) {
        BeaconProxy proxy = new BeaconProxy(address(beacon),
                                            abi.encodeWithSignature("initialize(address)", eigenPodManager)
                                           );

        IPodOwner podOwner = IPodOwner(address(proxy));
        podOwners.push(podOwner);
    }


    /**
     * ======================================================================================
     * 
     *  EXTERNAL VIEW FUNCTIONS
     *
     * ======================================================================================
     */

    /**
     * @dev get unrealized profits that stays on eigenpods.
     */
    function getPendingWithdrawalAmount() external view returns (uint256) {
        uint256 sumBalance;
        for (uint256 i=0;i< podOwners.length;i++) {
            address podOwner = address(podOwners[i]);
            address pod = address(IEigenPodManager(eigenPodManager).getPod(podOwner));
            sumBalance += pod.balance;
            sumBalance += podOwner.balance;
        }

        return sumBalance;
    }


    /**
     * @dev get total pods
     */
    function getTotalPods() external view returns (uint256) {
        return podOwners.length;
    }

    /**
     * @dev get i-th eigenpod address
     */
    function getPod(uint256 i) external view returns (address) {
        IPodOwner podOwner = podOwners[i];
        return address(IEigenPodManager(eigenPodManager).getPod(address(podOwner)));
    }


    /**
     * ======================================================================================
     * 
     *  PRIMARY POD FUNCTIONS
     *
     * ======================================================================================
     */

    /**
     * @dev update function to withdraw rewards from eigenpod to staking contract
     */
    function update() external {
        // withdraw ethers to staking contract
        _withdrawEthers();
    }

    /**
     * ======================================================================================
     * 
     *  INTERNAL PODS FUNCTIONS
     *
     * ======================================================================================
     */

    function _withdrawEthers() internal {
        uint256 totalDiff;
        for (uint256 i=0;i< podOwners.length;i++) {
            IPodOwner podOwner = podOwners[i];
            totalDiff += address(podOwner).balance;
            podOwner.transfer(stakingAddress, address(podOwner).balance);
        }
        emit Claimed(totalDiff);
    }

    // @dev the magic to make restaking contract compatible to IPodOwner
    //  so we can unify the the method to handle eigenpods. 
    //  Access to this function must be limited to the contract itself.
    function execute(address target, bytes memory data) onlySelf external returns(bytes memory) {
        return target.functionCall(data);
    }

    function transfer(address target, uint256 amount) onlySelf external {
        payable(target).sendValue(amount);
    }

    /**
     * ======================================================================================
     * 
     * EVENTS
     *
     * ======================================================================================
     */
    event Claimed(uint256 amount);
    event Pending(uint256 amount);
}
