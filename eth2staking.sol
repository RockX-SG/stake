// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./library.sol";

contract ETH2Staking is ReentrancyGuard, Pausable, Ownable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;
    using Address for address payable;
    using SafeMath for uint256;

    uint256 internal constant DEPOSIT_SIZE = 32 ether;
    uint256 internal constant MULTIPLIER = 1e18; 

    address public ethDepositContract; // ETH 2.0 Deposit contract
    address public xETHAddress; // xETH token address
    address public managerAccount;
    uint256 public managerFeeMilli = 100; // *1/1000

    struct Credential {
        bytes pubkey;
        bytes32 withdrawalCredential;
        bytes signature;
        bytes32 depositDataRoot;
    }

    // credentials, pushed by owner
    Credential [] public credentials;

    // next validator id
    uint256 nextValidatorId;

    // revenue distribution related
    uint256 public totalStaked;
    uint256 public totalDeposited;
    uint256 public totalUserRevenue;
    uint256 public totalManagerRevenue;
    uint256 public redeemableEthers;

    /**
     * Global
     */

    constructor(address xETHAddress_, address ethDepositContract_) public {
        ethDepositContract = ethDepositContract_;
        xETHAddress = xETHAddress_;
        managerAccount = msg.sender;
    }

    /**
     * @dev add credential by owner
     */
    function addCredential(bytes calldata pubkey, bytes32 withdrawalCredential, bytes calldata signature, bytes32 depositDataRoot) external onlyOwner {
        Credential memory cred;
        cred.pubkey = pubkey;
        cred.withdrawalCredential = withdrawalCredential;
        cred.signature = signature;
        cred.depositDataRoot = depositDataRoot;

        credentials.push(cred);
    }
    
    // set manager's account
    function setManagerAccount(address account) external onlyOwner {
        require(account != address(0x0));
        managerAccount = account;

        emit ManagerAccountSet(account);
    }

    // set manager's fee in 1/1000
    function setManagerFeeMilli(uint256 milli) external onlyOwner {
        require(milli >=0 && milli <=1000);
        managerFeeMilli = milli;

        emit ManagerFeeSet(milli);
    }


    /**
     * receive revenue
     */
    receive() external payable {}
    
    /**
     * revenue credit, before 2.0 launching
     */
    function revenueCredit(uint256 creditEthers) external onlyOwner {
        uint256 fee = creditEthers.mul(managerFeeMilli).div(1000);
        totalManagerRevenue = totalManagerRevenue.add(fee);

        totalUserRevenue = totalUserRevenue
                                .add(creditEthers)
                                .sub(fee);

        emit RevenueCredited(creditEthers);
    }

    /**
     * revenue distribute, after 2.0 launching
     */
    function revenueTransfer() external payable onlyOwner {
        uint256 fee = msg.value.mul(managerFeeMilli).div(1000);
        totalManagerRevenue = totalManagerRevenue.add(fee);

        uint256 diff = msg.value.sub(fee);
        totalUserRevenue = totalUserRevenue.add(diff);
        redeemableEthers = redeemableEthers.add(diff);

        emit RevenueTransfered(msg.value);
    }
    /**
     * view functions
     */
     /*
    function getStakers(uint256 validatorId) external view returns (AccountInfo[] memory list){
        return validators[validatorId].accountList;
    }
    */


    /**
     * @dev return exchange ratio of xETH:ETH, multiplied by 1e18
     */
    function exchangeRatio() public view returns (uint256) {
        uint256 xETHAmount = IERC20(xETHAddress).totalSupply();
        uint256 ratio = totalStaked.add(totalUserRevenue)
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
    function redeemUnderlying(uint256 ethersToRedeem) external nonReentrant {
        require(redeemableEthers >= ethersToRedeem);
        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 currentEthers = totalStaked.add(totalUserRevenue);
        uint256 toBurn = totalXETH.mul(ethersToRedeem).div(currentEthers);
        
        // transfer xETH from sender & burn
        IERC20(xETHAddress).safeTransferFrom(msg.sender, address(this), toBurn);
        IMintableContract(xETHAddress).burn(toBurn);

        // send ethers back to sender
        msg.sender.sendValue(ethersToRedeem);
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
    function redeem(uint256 xETHToBurn) external nonReentrant {
        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 currentEthers = totalStaked.add(totalUserRevenue);
        uint256 ethersToRedeem = currentEthers.mul(xETHToBurn).div(totalXETH);
        require(redeemableEthers >= ethersToRedeem);

        // transfer xETH from sender & burn
        IERC20(xETHAddress).safeTransferFrom(msg.sender, address(this), xETHToBurn);
        IMintableContract(xETHAddress).burn(xETHToBurn);

        // send ethers back to sender
        msg.sender.sendValue(ethersToRedeem);
    }

    /**
     * @dev spin up the node
     */
    function _spinup() internal {
        // emit a log
        emit NewValidator(nextValidatorId);

        // deposit to ethereum contract
        require(nextValidatorId + 1 < credentials.length) ;
        Credential memory cred = credentials[nextValidatorId];
        _stake(cred.pubkey, cred.signature, cred.withdrawalCredential, cred.depositDataRoot);

        totalDeposited += DEPOSIT_SIZE;
        nextValidatorId++;        
    }

    /**
    * @dev Invokes a deposit call to the official Deposit contract
    */
    function _stake(bytes memory _pubkey, 
        bytes memory _signature, 
        bytes32 _withdrawCredential, 
        bytes32 _depositDataRoot) 
        internal {

        IDepositContract(ethDepositContract).deposit{value:DEPOSIT_SIZE} (
            _pubkey, abi.encodePacked(_withdrawCredential), _signature, _depositDataRoot);

        uint256 targetBalance = address(this).balance.sub(DEPOSIT_SIZE);
        require(address(this).balance == targetBalance, "EXPECTING_DEPOSIT_TO_HAPPEN");
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