// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "interfaces/iface.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";


contract RockXRedeem is IRockXRedeem, Initializable, PausableUpgradeable, ReentrancyGuardUpgradeable, OwnableUpgradeable {
    using SafeERC20 for IERC20;
    using Address for address payable;

    mapping(address=>uint256) private balances;

    /**
     * @dev initialization
     */
    function initialize() initializer public {
        __Ownable_init();
        __Pausable_init();
        __ReentrancyGuard_init();
    }

    /**
     * @dev pay debts
     */
    function pay(address account) external override payable {
        balances[account] += msg.value;

        // log
        emit Paied(account, msg.value);
    }

    /**
     * @dev claim 
     */
    function claim(uint256 amount) external override nonReentrant {
        require(balances[msg.sender] >= amount, "INSUFFICIENT_BALANCE");
        balances[msg.sender] -= amount;
        payable(msg.sender).sendValue(amount);

        // log
        emit Claimed(msg.sender, amount);
    }

    /**
     * @dev balance of claimable debts
     */
    function balanceOf(address account) external override view returns(uint256) { return balances[account]; }

    event Paied(address account, uint256 amount);
    event Claimed(address account, uint256 amount);
}
