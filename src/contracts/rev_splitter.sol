// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "interfaces/iface.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

/**
 * @title Bedrock Revenue Splitter
 * @dev this contract receives manager's uniETH from Staking contract, and
 *  split with node operator and bedrock.
 */
contract RevenueSplitter is Initializable, AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    // @dev staking contract address
    address public stakingAddress;

    constructor() {
        _disableInitializers();
    }

    function initialize(address stakingAddress_) public initializer {
        stakingAddress = stakingAddress_;
    }
}
