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

    uint256 internal constant NODE_ETH_LIMIT = 32 ether;
    uint256 internal constant SHARE_MULTIPLIER = 1e18; 

    address public managerAccount;
    uint256 public managerFeeMilli = 100; // *1/1000

    struct Validator {
        // fields related before validator setup
        mapping(address=>uint256) accounts;
        uint256 totalEthers;

        // fields after validator has spinned up
        mapping(address=>uint256) rewardDebts;
        uint256 accEthersPerShare;

        bool hasWithdrawed;
    }

    address public nextValidator; // still waiting for ether deposits
    mapping(address=>Validator) internal nodes; // spined up nodes
    address [] public validators;
    uint256 public numValidators;

    /**
     * Global
     */

    constructor() public {
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
        uint256 share = msg.value.sub(fee)
                            .mul(SHARE_MULTIPLIER)
                            .div(nodes[msg.sender].totalEthers);

        nodes[msg.sender].accEthersPerShare = nodes[msg.sender].accEthersPerShare.add(share);

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
    function checkReward(address account, address validator) public view returns (uint256) {
        Validator storage node = nodes[validator];
        uint256 amount = node.accounts[account];
        uint256 rewardDebt = node.rewardDebts[account];

        uint256 revenue = amount
                                .mul(node.accEthersPerShare.sub(rewardDebt))
                                .div(SHARE_MULTIPLIER);
        return revenue;
    }

    /**
     * claim rewards and update reward debts
     */ 
    function claimRewards(address validator) external nonReentrant {
        uint256 rewards = checkReward(msg.sender, validator);
        Validator storage node = nodes[validator];
        node.rewardDebts[msg.sender] = node.accEthersPerShare;
        msg.sender.sendValue(rewards);
    }
 
    function deposit() external 
        payable 
        nonReentrant 
        whenNotPaused 
    {
        require(msg.value > 0, "amount 0");

        // allocate eth to validators
        uint256 ethersRemain = msg.value;
        
        while (ethersRemain > 0) {
            Validator storage node = nodes[nextValidator];
            if (node.totalEthers.add(ethersRemain) >= NODE_ETH_LIMIT) {
                // bound to 32 ethers
                uint256 incr =  NODE_ETH_LIMIT.sub(node.totalEthers);
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
    }

    // spin up the node
    function _spinup() internal {
        // emit a log
        emit NewValidator(nextValidator);

        // deploy new contract to receive revenue
        nextValidator = address(new ETH2Validator());
        validators.push(nextValidator);
        numValidators = validators.length;
    }

    // withdraw 32 ethers
    function withdraw(address validator) external nonReentrant onlyOwner {
        Validator storage node = nodes[validator];
        require(node.totalEthers >= NODE_ETH_LIMIT);
        require(!node.hasWithdrawed);

        node.hasWithdrawed = true;
        
        msg.sender.sendValue(node.totalEthers);
    }

    /**
     * Events
     */
    event NewValidator(address account);
    event RevenueReceived(uint256 amount);
    event ManagerAccountSet(address account);
    event ManagerFeeSet(uint256 milli);
}
