// SPDX-License-Identifier: AGPL-3.0-or-later
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⢠⣤⣤⣤⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⠉⠻⣿⡟⠛⠛⠻⣿⣄⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⡀⡀⡀⡀⡀⡀⡀⠙⢿⣿⡟⠁⡀⡀⠙⣿⠟⠁
// ⡀⡀⣿⡇⡀⡀⡀⢸⣿⡆⡀⡀⡀⡀⡀⣀⣀⡀⡀⡀⡀⡀⡀⡀⡀⣀⣀⣀⡀⡀⡀⡀⣿⣿⡀⡀⡀⡀⡀⡀⡀⡀⡀⢿⣿⡄⡀⡀⣾⠃⡀⡀
// ⡀⡀⣿⡇⡀⡀⡀⢸⣿⠃⡀⡀⡀⣾⡿⠉⠉⠙⣿⣄⡀⡀⡀⣴⣿⠋⠉⠻⣿⡄⡀⡀⣿⣿⡀⡀⠙⣿⠿⠉⡀⡀⡀⡀⢻⣿⣄⣿⠁⡀⡀⡀
// ⡀⡀⣿⣇⣀⣀⣤⡿⠋⡀⡀⡀⣼⣿⡀⡀⡀⡀⢸⣿⡀⡀⢠⣿⠃⡀⡀⡀⠛⡀⡀⡀⣿⣿⡀⢀⡿⠁⡀⡀⡀⡀⡀⡀⡀⢻⣿⡄⡀⡀⡀⡀
// ⡀⡀⣿⡏⠉⠻⣿⣄⡀⡀⡀⡀⣿⣿⡀⡀⡀⡀⠘⣿⡇⡀⢸⣿⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣴⣿⣦⡀⡀⡀⡀⡀⡀⡀⢠⡿⢻⣿⡄⡀⡀⡀
// ⡀⡀⣿⡇⡀⡀⠻⣿⣆⡀⡀⡀⢿⣿⡀⡀⡀⡀⢸⣿⠁⡀⢸⣿⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⡀⠘⣿⣧⡀⡀⡀⡀⡀⣰⡟⡀⡀⢻⣿⡄⡀⡀
// ⡀⢀⣿⣧⡀⡀⡀⠻⣿⣦⡀⡀⠈⣿⣄⡀⡀⡀⣾⡿⡀⡀⡀⢿⣷⡀⡀⡀⣀⡄⡀⡀⣿⣿⡀⡀⠈⣿⣷⡀⡀⡀⣴⣿⡀⡀⡀⡀⢻⣿⣄⡀
// ⠛⠛⠛⠛⠛⡀⡀⡀⠈⠛⠛⡀⡀⡀⠛⠿⠿⠟⠋⡀⡀⡀⡀⡀⠙⠿⠿⠿⠛⡀⠘⠛⠛⠛⠛⡀⡀⡀⠙⠛⠛⠛⠛⠛⠛⡀⡀⠛⠛⠛⠛⠛
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
pragma solidity ^0.8.9;

import "interfaces/IStaking.sol";
import "interfaces/IVotingEscrow.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

 /**
  * @title Rockx Voting-escrow Rewards Contract
  * @author RockX Team
  */
contract VeRewards is IStaking, Initializable, OwnableUpgradeable, PausableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;

    uint256 public constant WEEK = 604800;
    uint256 public maxWeeks = 50; // max number of weeks a user can claim rewards in a single transaction
    mapping(address => uint256) public userLastSettledWeek; // user's last settled week
    mapping(uint256 => uint256) public profitsRealizedWeekly; // week -> rewards
    uint256 public lastRealizedProfitsTime; // the last realized profits time, the profits before which has finalized in weeklyRewards.

    uint256 public accountedBalance; // for tracking of rewards
    address public votingEscrow; // the voting escrow contract
    address public rewardToken; // the reward token to distribute to users as rewards
    address public approvedAccount; // the account who owns the to-be distributed rewards,
                                    // a multi-sig wallet is recommended.

    uint256 public genesis; // the genesis week the contract has deployed
    uint256 public unrealizedProfits;  // unrealized profits to be distributed in next week
    uint256 public profitsRealizingTime; // the expected profits realizing time

    /**
     * @dev empty reserved space for future adding of variables
     */
    uint256[32] private __gap;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /**
     * @dev This contract will not accept direct ETH transactions.
     */
    receive() external payable {
        revert("Do not send ETH here");
    }

    function initialize(address _votingEscrow, address _rewardToken, address _approvedAccount) initializer public {
        __Pausable_init();
        __Ownable_init();

        require(_votingEscrow != address(0x0), "_lpToken nil");
        require(_rewardToken != address(0x0), "_rewardToken nil");
        require(_approvedAccount != address(0x0), "_rewardToken nil");

        votingEscrow = _votingEscrow;
        rewardToken = _rewardToken;
        approvedAccount = _approvedAccount;

        genesis = _getWeek(block.timestamp);
        lastRealizedProfitsTime = genesis;
        profitsRealizingTime = _getWeek(block.timestamp+WEEK);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     *
     *      EXTERNAL FUNCTIONS
    *
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */

    /**
     * @dev claim rewards
     */
    function claim() external nonReentrant whenNotPaused {
        // try to realized profits
        _updateReward();

        // calc rewards and update settled week
        (uint256 reward, uint256 settledToWeek) = _calcPendingRewards(msg.sender);
        userLastSettledWeek[msg.sender] = settledToWeek;

        // transfer profits to user
        IERC20(rewardToken).safeTransferFrom(approvedAccount, msg.sender, reward);

        // track balance decrease
        _balanceDecrease(reward);

        // log
        emit Claim(msg.sender, reward);
    }

    /**
     * @dev updateReward
     */
    function updateReward() external override {  _updateReward(); }

    /**
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     *
     *      VIEW FUNCTIONS
     *
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */
     function getPendingReward(address account) external view returns (uint256) {
        (uint256 rewards,) = _calcPendingRewards(account);

        // check if profits has realized
        if (block.timestamp > profitsRealizingTime) {
            // accumulate rewards
            rewards += unrealizedProfits * IVotingEscrow(votingEscrow).balanceOfAt(account, profitsRealizingTime) / IVotingEscrow(votingEscrow).totalSupplyAt(profitsRealizingTime);
        }
        return rewards;
     }

    /**
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     *
     *      INTERNALS
     *
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */
    function _balanceDecrease(uint256 amount) internal { accountedBalance -= amount; }

    /**
     * @dev internal calculation of rewards for a user
     */
    function _calcPendingRewards(address account) internal view returns (uint256 rewards, uint256 settledToWeek) {
        // load user's last settled week
        settledToWeek = userLastSettledWeek[account];
        if (settledToWeek < genesis) {
            settledToWeek = genesis;
        }

        // claim to maxWeeks rewards
        for (uint i=0; i<maxWeeks;i++) {
            uint256 nextWeek = settledToWeek + WEEK;
            if (nextWeek > lastRealizedProfitsTime || nextWeek > block.timestamp) {
                break;
            }
            settledToWeek = nextWeek;

            // settle this week ==> lastSettledWeek
            rewards += profitsRealizedWeekly[settledToWeek]
                        * IVotingEscrow(votingEscrow).balanceOfAt(account, settledToWeek)
                        / IVotingEscrow(votingEscrow).totalSupplyAt(settledToWeek);
        }

        return (rewards, settledToWeek);
    }

    /**
     * @dev compare balance remembered to current balance to find the increased reward.
     */
    function _updateReward() internal {
        // check if pending profits has realized
        if (block.timestamp > profitsRealizingTime) {
            lastRealizedProfitsTime = profitsRealizingTime;
            profitsRealizedWeekly[profitsRealizingTime] = unrealizedProfits; // <- profits realized

            // rewards reset to 0 in next week.
            unrealizedProfits = 0;
            profitsRealizingTime = _getWeek(block.timestamp+WEEK);
        }

        // accumulate new rewards to 'unrealizedProfits' .
        uint256 balance = IERC20(rewardToken).balanceOf(address(this));
        if (balance > accountedBalance) {
            uint256 rewards = balance - accountedBalance;
            accountedBalance = balance;
            unrealizedProfits += rewards;
        }
    }

    /**
     *  @notice Get the based on the ts.
     *  @param _ts arbitrary time stamp.
     *  @return returns the 00:00 am UTC for THU after _ts
     */
    function _getWeek(uint256 _ts) private pure returns (uint256) {
        return (_ts / WEEK) * WEEK;
    }

    /**
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     *
     *      EVENTS
     *
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */
     event Claim(address account, uint256 amount);
}