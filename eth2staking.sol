// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "./library.sol";

contract ETH2Staking is ReentrancyGuard, Pausable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;
    using Address for address payable;
    using SafeMath for uint256;

    uint256 internal NODE_ETH_LIMIT = 32 ether;

    receive() external payable {}

    struct Validator {
        mapping(address=>uint256) accounts;
        uint256 created_at;
        uint256 spinup_at;
        uint256 total;
    }

    Validator [] private validators;

    /**
     * view functions
     */
     /*
    function getStakers(uint256 validatorId) external view returns (AccountInfo[] memory list){
        return validators[validatorId].accountList;
    }
    */
 
    function deposit() external 
        payable 
        nonReentrant 
        whenNotPaused 
    {
        require(msg.value > 0, "amount 0");

        // initial validator
        if (validators.length == 0) {
            _nextValidator();
        }
        
        // allocate eth to validators
        uint256 ethersRemain = msg.value;
        while (ethersRemain > 0) {
            // load the latest validator node
            Validator storage node = validators[validators.length-1];

            if (node.total.add(ethersRemain) >= NODE_ETH_LIMIT) {
                uint256 incr =  NODE_ETH_LIMIT.sub(node.total);
                ethersRemain = ethersRemain.sub(incr);
                node.total = node.total.add(incr);
                node.accounts[msg.sender] = node.accounts[msg.sender].add(incr);
                node.spinup_at = block.timestamp;
                // emit a log
                emit NewValidator(validators.length-1);

                // open next validator
                _nextValidator();

            } else {
                node.total = node.total.add(ethersRemain);
                node.accounts[msg.sender] = node.accounts[msg.sender].add(ethersRemain);
                ethersRemain = 0;
            }
        }
    }


    // push an empty new validator entry to validators
    function _nextValidator() internal {
        Validator memory val;
        val.created_at = block.timestamp;
        validators.push(val);
    }

    /**
     * Events
     */
    event NewValidator(uint256 id);
}
