// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./library.sol";


// ETH2Validator is a standalone address to receive revenue
contract ETH2Validator is Ownable {
    using Address for address payable;

    receive() external payable {
        IETH2Staking(owner()).revenueRecevied{value:msg.value}();
    }
}

contract ETH2Staking is IETH2Staking, ReentrancyGuard, Pausable, Ownable {
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

    struct Validator {
        // fields related before validator setup
        mapping(address=>uint256) accounts;
        uint256 totalEthers;
        bool hasWithdrawed;
    }

    // validator start up related;
    address public nextValidator; // still waiting for ether deposits
    mapping(address=>Validator) internal nodes; // spined up nodes
    address [] public validators;
    uint256 public numValidators;

    // revenue distribution related
    uint256 totalStaked;
    uint256 totalRevenue;

    // pending withdraw
    mapping(address=>uint256) pendingRedeem;

    /**
     * Global
     */

    constructor(address xETHAddress_, address ethDepositContract_) public {
        ethDepositContract = ethDepositContract_;
        xETHAddress = xETHAddress_;
        managerAccount = msg.sender;
        nextValidator = address(new ETH2Validator());
        validators.push(nextValidator);
        numValidators = validators.length;
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
     * revenue received for a given validator
     */
    function revenueRecevied() external override payable {
        uint256 fee = msg.value.mul(managerFeeMilli).div(1000);

        payable(managerAccount).sendValue(fee);
        totalRevenue = msg.value
                            .sub(fee)
                            .add(totalRevenue);

        emit RevenueReceived(msg.value);
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
        uint256 ratio = totalStaked.add(totalRevenue)
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
        uint256 currentEthers = totalStaked.add(totalRevenue);
        uint256 toMint = amountXETH.mul(currentEthers.add(msg.value)).div(currentEthers).sub(amountXETH);

        // allocate ethers to validators
        uint256 ethersRemain = msg.value;        
        while (ethersRemain > 0) {
            Validator storage node = nodes[nextValidator];
            if (node.totalEthers.add(ethersRemain) >= DEPOSIT_SIZE) {
                // bound to 32 ethers
                uint256 incr =  DEPOSIT_SIZE.sub(node.totalEthers);
                ethersRemain = ethersRemain.sub(incr);
                node.totalEthers = node.totalEthers.add(incr);
                node.accounts[msg.sender] = node.accounts[msg.sender].add(incr);
        
                // spin up node
                _spinup();

            } else {
                node.totalEthers = node.totalEthers.add(ethersRemain);
                node.accounts[msg.sender] = node.accounts[msg.sender].add(ethersRemain);
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
        require(totalRevenue >= ethersToRedeem);
        uint256 totalXETH = IERC20(xETHAddress).totalSupply();
        uint256 currentEthers = totalStaked.add(totalRevenue);
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
        uint256 currentEthers = totalStaked.add(totalRevenue);
        uint256 ethersToRedeem = currentEthers.mul(xETHToBurn).div(totalXETH);
        require(totalRevenue >= ethersToRedeem);

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
        emit NewValidator(nextValidator);

        // deploy new contract to receive revenue
        nextValidator = address(new ETH2Validator());
        validators.push(nextValidator);
        numValidators = validators.length;

        // TODO: deposit to ethereum contract
    }

    /**
    * @dev Invokes a deposit call to the official Deposit contract
    * @param _pubkey Validator to stake for
    * @param _signature Signature of the deposit call
    */
    function _stake(bytes memory _pubkey, bytes memory _signature) internal {
        bytes32 withdrawalCredentials;
        bytes32 depositDataRoot;

        IDepositContract(ethDepositContract).deposit{value:DEPOSIT_SIZE} (
            _pubkey, abi.encodePacked(withdrawalCredentials), _signature, depositDataRoot);

        uint256 targetBalance = address(this).balance.sub(DEPOSIT_SIZE);
        require(address(this).balance == targetBalance, "EXPECTING_DEPOSIT_TO_HAPPEN");
    }

    /**
     * Events
     */
    event NewValidator(address account);
    event RevenueReceived(uint256 amount);
    event ManagerAccountSet(address account);
    event ManagerFeeSet(uint256 milli);
    event Withdrawed(address validator);
}