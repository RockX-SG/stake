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
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

 /**
  * @title Rockx Liquid Staking LP Pair Incentives
  * @author RockX Team
  */
contract LPStaking is IStaking, Initializable, OwnableUpgradeable, PausableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20 for IERC20;
    using SafeMath for uint;

    uint256 private constant MULTIPLIER = 1e18;
    uint256 public constant WEEK = 604800;

    struct UserInfo {
        uint256 accSharePoint; // share starting point
        uint256 amount; // user's share
        uint256 rewardBalance;  // user's pending reward
    }

    uint256 private totalShares; // total shares
    uint256 private accShare;   // accumulated earnings per 1 share

    // current realized profit delivery rate, this profit should be distributed linearly in a week,
    // otherwise, users can sandwich stake & unstake on newly received rewards
    uint256 public unrealizedProfits;   // current unrealized profits(to be distributed to users at some rate)
    uint256 public unrealizedProfitsUpdateTime;   // latest profits update time
    uint256 public profitsRealizingTime;  // the expected profits realizing time

    mapping(address => UserInfo) public userInfo; // claimaddr -> info
    uint256 private accountedBalance;   // for tracking of rewards

    address public lpToken; // the ERC20 lp token to staking
    address public rewardToken; // the reward token to distribute to users as rewards

    uint256 private _lastRewardBlock = block.number;

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

    function initialize(address _lpToken, address _rewardToken) initializer public {
        __Pausable_init();
        __Ownable_init();

        lpToken = _lpToken;
        rewardToken = _rewardToken;
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
     * @dev stake assets
     */
    function deposit(uint256 amount) external override nonReentrant whenNotPaused {
        _updateReward();

        UserInfo storage info = userInfo[msg.sender];

        // settle current pending distribution
        info.rewardBalance += (accShare - info.accSharePoint) * info.amount / MULTIPLIER;
        info.amount += amount;
        info.accSharePoint = accShare;

        // update total shares
        totalShares += amount;

        // transfer lp token
        IERC20(lpToken).safeTransferFrom(msg.sender, address(this), amount);

        // log
        emit Deposit(msg.sender, amount);
    }

    /**
     * @dev havest rewards
     */
    function havest(uint256 amount) external override nonReentrant whenNotPaused {
        _updateReward();

        UserInfo storage info = userInfo[msg.sender];

        // settle current pending distribution
        info.rewardBalance += (accShare - info.accSharePoint) * info.amount / MULTIPLIER;
        info.accSharePoint = accShare;

        // check
        require(info.rewardBalance >= amount, "INSUFFICIENT_REWARD");

        // account & transfer
        info.rewardBalance -= amount;
        _balanceDecrease(amount);
        IERC20(rewardToken).safeTransfer(msg.sender, amount);

        // log
        emit Havest(msg.sender, amount, 0);
    }

    /**
     * @dev withdraw the staked assets
     */
    function withdraw(uint256 amount) override external nonReentrant {
        _updateReward();

        UserInfo storage info = userInfo[msg.sender];
        require(info.amount >= amount, "INSUFFICIENT_AMOUNT");

        // settle current pending distribution
        info.rewardBalance += (accShare - info.accSharePoint) * info.amount / MULTIPLIER;
        info.amount -= amount;
        info.accSharePoint = accShare;

        // update total shares
        totalShares -= amount;

        // transfer lp token back
        IERC20(lpToken).safeTransfer(msg.sender, amount);

        // log
        emit Withdraw(msg.sender, amount);
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
     function getTotalShare() external view returns (uint256) { return totalShares; }
     function getAccountedBalance() external view returns (uint256) { return accountedBalance; }

     function getPendingReward(address claimaddr) external view returns (uint256) {
        UserInfo storage info = userInfo[claimaddr];
        if (totalShares == 0) {
            return info.rewardBalance;
        }

        uint256 realized = _getRealized();
        return info.rewardBalance + (accShare + realized * MULTIPLIER / totalShares - info.accSharePoint) * info.amount / MULTIPLIER;
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
     * @dev compare balance remembered to current balance to find the increased reward.
     */
    function _updateReward() internal {
        // reward distribution first
        uint256 realized = _getRealized();
        if (realized > 0 && totalShares > 0) {
            accShare += realized * MULTIPLIER / totalShares;
            unrealizedProfits -= realized;
            unrealizedProfitsUpdateTime = block.timestamp;
        }

        // accumulate new rewards
        uint256 balance = IERC20(rewardToken).balanceOf(address(this));
        if (balance > accountedBalance && totalShares > 0) {
            uint256 rewards = balance - accountedBalance;
            accountedBalance = balance;

            // profits linear realization
            //  unrealizedProfits(unrealizedProfitsUpdateTime) ---> 0(profitsRealizingTime)
            //     |                                                |
            //     |----- seconds passed----------------------------|

            unrealizedProfits += rewards;
            unrealizedProfitsUpdateTime = block.timestamp;
            profitsRealizingTime = _getWeek(block.timestamp + WEEK);
        }
    }

    /**
     * @dev calculate realized profits
     */
    function _getRealized() private view returns (
        uint256 realized
    ) {
        if (unrealizedProfits > 0) {
            if (block.timestamp > profitsRealizingTime) {
                realized = unrealizedProfits;
            } else {
                uint256 duration = profitsRealizingTime - unrealizedProfitsUpdateTime;
                uint256 timePassed = block.timestamp - unrealizedProfitsUpdateTime;
                realized = timePassed * unrealizedProfits / duration;
            }

            // make sure realized never exceeds unrealizedProfits
            if (realized > unrealizedProfits) {
                realized = unrealizedProfits;
            }
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
     event Deposit(address account, uint256 amount);
     event Withdraw(address account, uint256 amount);
     event Havest(address account, uint256 amount, uint256 duration);
}