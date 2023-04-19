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
    mapping(address => uint256) public userLastSettledWeek; // user's last settlement week
    mapping(uint256 => uint256) public profitsSettledWeekly; // week ts -> rewards settled
    uint256 public latestSettlement; // latest profits settlement time, the profits before which has finalized in profitsRealizedWeekly.

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

    function initialize(
        address _votingEscrow, 
        address _rewardToken
    ) initializer public {
        __Pausable_init();
        __Ownable_init();

        require(_votingEscrow != address(0x0), "_lpToken nil");
        require(_rewardToken != address(0x0), "_rewardToken nil");

        votingEscrow = _votingEscrow;
        rewardToken = _rewardToken;

        genesis = _getWeek(block.timestamp);
        latestSettlement = genesis;
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
     * @dev claim all rewards
     */
    function claim() external nonReentrant whenNotPaused {
        // try to realized profits
        _updateReward();

        // calc realized rewards and update settled week
        (uint256 reward, uint256 settledWeek) = _calcRealizedRewards(msg.sender);
        userLastSettledWeek[msg.sender] = settledWeek;

        // transfer profits to user
        IERC20(rewardToken).safeTransfer(msg.sender, reward);

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
        // realized rewards
        (uint256 rewards,) = _calcRealizedRewards(account);

        // check if unrealized profits could be realized.
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
     * @dev internal calculation of realized rewards for a user
     */
    function _calcRealizedRewards(address account) internal view returns (uint256 rewards, uint256 settledWeek) {
        // load user's last settled week
        settledWeek = userLastSettledWeek[account];
        if (settledWeek < genesis) {
            settledWeek = genesis;
        }

        // claim to maxWeeks rewards
        for (uint i=0; i<maxWeeks;i++) {
            // loop until we reached last settlement in the past
            uint256 nextWeek = settledWeek + WEEK;
            if (nextWeek > latestSettlement || nextWeek > block.timestamp) {
                break;
            }
            settledWeek = nextWeek;

            // settle this week ==> lastSettledWeek
            rewards += profitsSettledWeekly[settledWeek]
                        * IVotingEscrow(votingEscrow).balanceOfAt(account, settledWeek)
                        / IVotingEscrow(votingEscrow).totalSupplyAt(settledWeek);
        }

        return (rewards, settledWeek);
    }

    /**
     * @dev compare balance remembered to current balance to find the increased reward.
     */
    function _updateReward() internal {
        // check if pending profits has realized
        if (block.timestamp > profitsRealizingTime) {
            profitsSettledWeekly[profitsRealizingTime] = unrealizedProfits; // <- profits settled
            latestSettlement = profitsRealizingTime;

            // reset unrealized profits to 0 in the up-coming week.
            unrealizedProfits = 0;
            profitsRealizingTime = _getWeek(block.timestamp+WEEK);
        }

        // accumulate new profits to 'unrealizedProfits'
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