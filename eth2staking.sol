// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./library.sol";
import "solidity-bytes-utils/contracts/BytesLib.sol";


contract ETH2Staking is ReentrancyGuard, Pausable, Ownable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;
    using Address for address payable;
    using Address for address;
    using SafeMath for uint256;

    uint256 internal constant DEPOSIT_SIZE = 32 ether;
    uint256 internal constant MULTIPLIER = 1e18; 
    uint256 internal constant DEPOSIT_AMOUNT_UNIT = 1000000000 wei;
    uint256 constant public SIGNATURE_LENGTH = 96;


    address public ethDepositContract; // ETH 2.0 Deposit contract
    address public xETHAddress; // xETH token address
    address public managerAccount;
    uint256 public managerFeeMilli = 100; // *1/1000
    bytes32 public withdrawalCredentials;

    // stored credentials
    struct Credential {
        bytes pubkey;
        bytes signature;
    }

    // credentials, pushed by owner
    Credential [] public credentials;

    // next validator id
    uint256 nextValidatorId;

    // revenue distribution related
    uint256 public totalStaked;
    uint256 public totalDeposited;
    uint256 public bufferedRevenue; // bufferedRevenue -> (user revenue + manager revenue)
    uint256 public totalUserRevenue;
    uint256 public totalManagerRevenue;
    uint256 public redeemableEthers;
    
    /**
     * Global
     */
    constructor(
        address xETHAddress_, 
        address ethDepositContract_
    ) {
        ethDepositContract = ethDepositContract_;
        xETHAddress = xETHAddress_;
        managerAccount = msg.sender;
    }

    /**
     * @dev add credential by owner
     */
    function addCredential(
        bytes calldata pubkey, 
        bytes calldata signature
    ) 
        external 
        onlyOwner 
    {
        Credential memory cred;
        cred.pubkey = pubkey;
        cred.signature = signature;

        credentials.push(cred);
    }
    
    // set manager's account
    function setManagerAccount(
        address account
    ) 
        external 
        onlyOwner 
    {
        require(account != address(0x0));
        managerAccount = account;

        emit ManagerAccountSet(account);
    }

    // set manager's fee in 1/1000
    function setManagerFeeMilli(
        uint256 milli
    )
        external 
        onlyOwner 
    {
        require(milli >=0 && milli <=1000);
        managerFeeMilli = milli;

        emit ManagerFeeSet(milli);
    }


    /**
     * receive revenue
     */
    receive() 
        external 
        payable 
    {
        bufferedRevenue = bufferedRevenue.add(msg.value);
        emit RevenueTransfered(msg.value);
    }
    
    /**
     * revenue credit, before 2.0 launching
     */
    function revenueCredit(
        uint256 creditEthers
    ) 
        external 
        onlyOwner 
    {
        uint256 fee = creditEthers.mul(managerFeeMilli).div(1000);
        totalManagerRevenue = totalManagerRevenue.add(fee);

        totalUserRevenue = totalUserRevenue
                                .add(creditEthers)
                                .sub(fee);

        emit RevenueCredited(creditEthers);
    }

    /**
     * @dev return exchange ratio of xETH:ETH, multiplied by 1e18
     */
    function exchangeRatio() 
        public 
        view 
        returns (uint256) 
    {
        uint256 xETHAmount = IERC20(xETHAddress).totalSupply();
        uint256 bufferedUserRevenue = bufferedRevenue.mul(1000-managerFeeMilli).div(1000);
        uint256 ratio = totalStaked.add(totalUserRevenue.add(bufferedUserRevenue))
                            .mul(MULTIPLIER)
                            .div(xETHAmount);
        return ratio;
    }
 
    /**
     * @dev mint xETH with ETH
     */
    function mint() external 
        payable 
        nonReentrant 
        whenNotPaused 
    {
        require(msg.value > 0, "amount 0");
        _processBufferedRevenue();

        // mint xETH while keep the exchange ratio invariant
        //
        // amount XETH to mint = xETH * (current_ethers + ethers_to_deposit)/current_ethers - xETH
        //
        uint256 amountXETH = IERC20(xETHAddress).totalSupply();
        uint256 currentEthers = totalStaked.add(totalUserRevenue);
        uint256 toMint = amountXETH.mul(currentEthers.add(msg.value)).div(currentEthers).sub(amountXETH);

        // allocate ethers to validators
        uint256 ethersRemain = msg.value;        
        while (ethersRemain > 0) {
            if (totalStaked.add(ethersRemain).sub(totalDeposited) >= DEPOSIT_SIZE) {
                // bound to 32 ethers
                uint256 incr = totalDeposited.add(DEPOSIT_SIZE).sub(totalStaked);
                ethersRemain = ethersRemain.sub(incr);
        
                // spin up node with credentials
                _spinup();

            } else {
                ethersRemain = 0;
            }
        }

        // sum total ethers
        totalStaked = totalStaked.add(msg.value);
        // mint xETH
        IMintableContract(xETHAddress).mint(msg.sender, toMint);
    }

    /**
     * @dev redeem ETH by burning xETH with current exchange ratio, 
     * approve xETH to this contract first.
     *
     * amount xETH to burn:
     *      xETH * ethers_to_redeem/current_ethers
     *
     * redeem keeps the ratio invariant
     */
    function redeemUnderlying(
        uint256 ethersToRedeem
    )
        external 
        nonReentrant 
    {
        _processBufferedRevenue();

        require(redeemableEthers >= ethersToRedeem);
        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 currentEthers = totalStaked.add(totalUserRevenue);
        uint256 toBurn = totalXETH.mul(ethersToRedeem).div(currentEthers);
        
        // transfer xETH from sender & burn
        IERC20(xETHAddress).safeTransferFrom(msg.sender, address(this), toBurn);
        IMintableContract(xETHAddress).burn(toBurn);

        // send ethers back to sender
        payable(msg.sender).sendValue(ethersToRedeem);
    }

    /**
     * @dev redeem ETH by burning xETH with current exchange ratio, 
     * approve xETH to this contract first.
     * 
     * amount ethers to return:
     *  current_ethers * xETHToBurn/ xETH
     *
     * redeem keeps the ratio invariant
     */
    function redeem(
        uint256 xETHToBurn
    )
        external 
        nonReentrant 
    {
        _processBufferedRevenue();

        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 currentEthers = totalStaked.add(totalUserRevenue);
        uint256 ethersToRedeem = currentEthers.mul(xETHToBurn).div(totalXETH);
        require(redeemableEthers >= ethersToRedeem);

        // transfer xETH from sender & burn
        IERC20(xETHAddress).safeTransferFrom(msg.sender, address(this), xETHToBurn);
        IMintableContract(xETHAddress).burn(xETHToBurn);

        // send ethers back to sender
        payable(msg.sender).sendValue(ethersToRedeem);
    }

    /**
     * @dev process buffered revenue
     */
    function _processBufferedRevenue() internal {
        if (bufferedRevenue > 0) {
            uint256 fee = bufferedRevenue.mul(managerFeeMilli).div(1000);
            totalManagerRevenue = totalManagerRevenue.add(fee);

            uint256 diff = bufferedRevenue.sub(fee);
            totalUserRevenue = totalUserRevenue.add(diff);
            redeemableEthers = redeemableEthers.add(diff);

            bufferedRevenue = 0;
        }
    }

    /**
     * @dev spin up the node
     */
    function _spinup() internal {
        // emit a log
        emit NewValidator(nextValidatorId);

        // deposit to ethereum contract
        require(nextValidatorId + 1 < credentials.length) ;

         // load credential
        Credential memory cred = credentials[nextValidatorId];
        _stake(cred.pubkey, cred.signature);

        totalDeposited += DEPOSIT_SIZE;
        nextValidatorId++;        
    }

    /**
    * @dev Invokes a deposit call to the official Deposit contract
    */
    function _stake(
        bytes memory _pubkey, 
        bytes memory _signature)
        internal 
    {

         // The following computations and Merkle tree-ization will make official Deposit contract happy
        uint256 value = DEPOSIT_SIZE;
        uint256 depositAmount = value.div(DEPOSIT_AMOUNT_UNIT);
        assert(depositAmount.mul(DEPOSIT_AMOUNT_UNIT) == value);    // properly rounded

        // Compute deposit data root (`DepositData` hash tree root) according to deposit_contract.sol
        bytes32 pubkeyRoot = sha256(_pad64(_pubkey));
        bytes32 signatureRoot = sha256(
            abi.encodePacked(
                sha256(BytesLib.slice(_signature, 0, 64)),
                sha256(_pad64(BytesLib.slice(_signature, 64, SIGNATURE_LENGTH.sub(64))))
            )
        );

        bytes32 depositDataRoot = sha256(
            abi.encodePacked(
                sha256(abi.encodePacked(pubkeyRoot, withdrawalCredentials)),
                sha256(abi.encodePacked(_toLittleEndian64(depositAmount), signatureRoot))
            )
        );

        IDepositContract(ethDepositContract).deposit{value:DEPOSIT_SIZE} (
            _pubkey, abi.encodePacked(withdrawalCredentials), _signature, depositDataRoot);

        uint256 targetBalance = address(this).balance.sub(DEPOSIT_SIZE);
        require(address(this).balance == targetBalance, "EXPECTING_DEPOSIT_TO_HAPPEN");
    }

    /**
      * @dev Padding memory array with zeroes up to 64 bytes on the right
      * @param _b Memory array of size 32 .. 64
      */
    function _pad64(bytes memory _b) internal pure returns (bytes memory) {
        assert(_b.length >= 32 && _b.length <= 64);
        if (64 == _b.length)
            return _b;

        bytes memory zero32 = new bytes(32);
        assembly { mstore(add(zero32, 0x20), 0) }

        if (32 == _b.length)
            return BytesLib.concat(_b, zero32);
        else
            return BytesLib.concat(_b, BytesLib.slice(zero32, 0, uint256(64).sub(_b.length)));
    }

    /**
      * @dev Converting value to little endian bytes and padding up to 32 bytes on the right
      * @param _value Number less than `2**64` for compatibility reasons
      */
    function _toLittleEndian64(uint256 _value) internal pure returns (uint256 result) {
        result = 0;
        uint256 temp_value = _value;
        for (uint256 i = 0; i < 8; ++i) {
            result = (result << 8) | (temp_value & 0xFF);
            temp_value >>= 8;
        }

        assert(0 == temp_value);    // fully converted
        result <<= (24 * 8);
    }

    /**
     * Events
     */
    event NewValidator(uint256 node_id);
    event RevenueCredited(uint256 amount);
    event RevenueTransfered(uint256 amount);
    event ManagerAccountSet(address account);
    event ManagerFeeSet(uint256 milli);
    event Withdrawed(address validator);
}