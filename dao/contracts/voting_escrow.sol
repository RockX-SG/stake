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

import "interfaces/IVotingEscrow.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

/**
 * @title Rockx Liquid Staking Voting Escrow
 * @author  Curve Finance (MIT) - original concept and implementation in Vyper
 *              (see https://github.com/curvefi/curve-dao-contracts/blob/master/contracts/VotingEscrow.vy)
 *          mStable (AGPL) - forking Curve's Vyper contract and porting to Solidity
 *              (see https://github.com/mstable/mStable-contracts/blob/master/contracts/governance/IncentivisedVotingLockup.sol)
 *          RockX Team - this version
 * @notice Adjustments
 *          1) virtual locking, this contract does not hold any assets, while farming protocol does,
 *               this enhanced the flexbility of veToken.
 *          2) role based, only eligible contracts(farming protocol) can create/extend locks.
 */

contract VotingEscrow is IVotingEscrow, Initializable, PausableUpgradeable, AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant FARM_ROLE = keccak256("FARM_ROLE");
    
    uint256 public constant WEEK = 7 days;
    uint256 public constant MAXTIME = 365 days;
    uint256 public constant MULTIPLIER = 10**18;
    
    enum LockAction {
        CREATE_LOCK,
        INCREASE_AMOUNT,
        INCREASE_TIME
    }
    
    struct Point {
        int128 bias;
        int128 slope;
        uint256 ts;
        uint256 blk;
    }

    struct LockedBalance {
        int128 amount;
        uint256 end;
    }

    // Lock state
    uint256 public globalEpoch;
    Point[] public pointHistory;
    mapping(address => Point[]) public userPointHistory;
    mapping(address => uint256) public userPointEpoch;
    mapping(uint256 => int128) public slopeChanges;
    mapping(address => LockedBalance) public locked;

    // Voting token - Checkpointed view only ERC20
    string public name;
    string public symbol;
    uint256 public decimals = 18;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        string memory _name,
        string memory _symbol) initializer public {
        __Pausable_init();
        __AccessControl_init();
        __ReentrancyGuard_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        
        // set token names
        name = _name;
        symbol = _symbol;

        // lock init
        Point memory init = Point({
            bias: int128(0),
            slope: int128(0),
            ts: block.timestamp,
            blk: block.number
        });

        pointHistory.push(init);
    }
  
    /** 
     * ======================================================================================
     * 
     * CONTRACT MANAGEMENT
     * 
     * ======================================================================================
     */
    /**
     * @dev This contract will not accept direct ETH transactions.
     */
    receive() external payable {
        revert("Do not send ETH here");
    }

    /**
     * @dev pause the contract
     */
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev unpause the contract
     */
    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /// @notice Public function to trigger global checkpoint
    function checkpoint() external {
        LockedBalance memory empty;
        _checkpoint(address(0), empty, empty);
    }

    /** 
     * ======================================================================================
     * 
     *     USER LOCK MANAGEMENT
     * 
     * ======================================================================================
     */
     /**
     * @dev Creates a new lock
     * @param _account The account to put lock on
     * @param _value Total units of StakingToken to lockup
     * @param _unlockTime Time at which the stake should unlock
     */
    function createLock(address _account, uint256 _value, uint256 _unlockTime)
        external
        override
        nonReentrant
        whenNotPaused
        onlyRole(FARM_ROLE)
    {
        uint256 unlock_time = _floorToWeek(_unlockTime); // Locktime is rounded down to weeks
        LockedBalance memory locked_ = LockedBalance({
            amount: locked[_account].amount,
            end: locked[_account].end
        });

        require(_value > 0, "Must stake non zero amount");
        require(locked_.amount == 0, "Withdraw old tokens first");

        require(unlock_time > block.timestamp, "Can only lock until time in the future");
        require(unlock_time <= block.timestamp + MAXTIME, "Exceeds maxtime");

        _depositFor(_account, _value, unlock_time, locked_, LockAction.CREATE_LOCK);
    }

    /**
     * @dev Increases amount of stake thats locked up & resets decay
     * @param _account The account to put lock on
     * @param _value Additional units of StakingToken to add to exiting stake
     */
    function increaseLockAmount(address _account, uint256 _value)
        external
        override
        nonReentrant
        whenNotPaused
        onlyRole(FARM_ROLE)
    {
        LockedBalance memory locked_ = LockedBalance({
            amount: locked[_account].amount,
            end: locked[_account].end
        });

        require(_value > 0, "Must stake non zero amount");
        require(locked_.amount > 0, "No existing lock found");
        require(locked_.end > block.timestamp, "Cannot add to expired lock. Withdraw");

        _depositFor(_account, _value, 0, locked_, LockAction.INCREASE_AMOUNT);
    }

    /**
     * @dev Increases length of lockup & resets decay
     * @param _unlockTime New unlocktime for lockup
     */
    function increaseLockLength(address _account, uint256 _unlockTime)
        external
        override
        nonReentrant
        whenNotPaused
        onlyRole(FARM_ROLE)
    {
        LockedBalance memory locked_ = LockedBalance({
            amount: locked[msg.sender].amount,
            end: locked[msg.sender].end
        });
        uint256 unlock_time = _floorToWeek(_unlockTime); // Locktime is rounded down to weeks

        require(locked_.amount > 0, "Nothing is locked");
        require(locked_.end > block.timestamp, "Lock expired");
        require(unlock_time > locked_.end, "Can only increase lock WEEK");
        require(unlock_time <= block.timestamp + MAXTIME, "Exceeds maxtime");

        _depositFor(_account, 0, unlock_time, locked_, LockAction.INCREASE_TIME);
    }

    /**
     * @dev Withdraws all the senders stake, providing lockup is over
    * @param _account User for which to withdraw
     */
    function withdraw(address _account) 
        external
        override
        nonReentrant
        whenNotPaused
        onlyRole(FARM_ROLE)
    {
        LockedBalance memory oldLock = LockedBalance({
            end: locked[_account].end,
            amount: locked[_account].amount
        });

        require(block.timestamp >= oldLock.end, "The lock didn't expire");
        require(oldLock.amount > 0, "Must have something to withdraw");

        uint256 value = SafeCast.toUint256(oldLock.amount);

        LockedBalance memory currentLock = LockedBalance({ end: 0, amount: 0 });
        locked[_account] = currentLock;

        _checkpoint(_account, oldLock, currentLock);

        emit Unlocked(_account, value, block.timestamp);
    }
    
    /** 
     * ======================================================================================
     * 
     *     PUBLIC VIEW FUNCTIONS
     * 
     * ======================================================================================
     */

    /**
     * @notice Returns the last available user point for a user
     * @param _account User address
     * @return bias i.e. y
     * @return slope i.e. linear gradient
     * @return ts i.e. time point was logged
     */
    function getLastUserPoint(address _account) external view returns (
        int128 bias,
        int128 slope,
        uint256 ts
    ) {
        uint256 uepoch = userPointEpoch[_account];
        if (uepoch == 0) {
            return (0, 0, 0);
        }
        Point memory point = userPointHistory[_account][uepoch];
        return (point.bias, point.slope, point.ts);
    }

    /**
     * @dev Get current user voting power
     * @param _account User for which to return the voting power
     * @return Voting power of user
     */
    function balanceOf(address _account) public view override returns (uint256) {
        uint256 epoch = userPointEpoch[_account];
        if (epoch == 0) {
            return 0;
        }
        Point memory lastPoint = userPointHistory[_account][epoch];
        lastPoint.bias =
            lastPoint.bias -
            (lastPoint.slope * SafeCast.toInt128(int256(block.timestamp - lastPoint.ts)));
        if (lastPoint.bias < 0) {
            lastPoint.bias = 0;
        }
        
        return SafeCast.toUint256(lastPoint.bias);
    }

    /**
     * @dev Get users voting power at a given blockNumber
     * @param _account User for which to return the voting power
     * @param _blockNumber Block at which to calculate voting power
     * @return uint256 Voting power of user
     */
    function balanceOfAt(address _account, uint256 _blockNumber)
        public
        view
        override
        returns (uint256)
    {
        require(_blockNumber <= block.number, "Only past block number");

        // Get most recent user Point to block
        uint256 userEpoch = _findUserBlockEpoch(_account, _blockNumber);
        if (userEpoch == 0) {
            return 0;
        }
        Point memory upoint = userPointHistory[_account][userEpoch];

        // Get most recent global Point to block
        uint256 maxEpoch = globalEpoch;
        uint256 epoch = _findBlockEpoch(_blockNumber, maxEpoch);
        Point memory point0 = pointHistory[epoch];

        // Calculate delta (block & time) between user Point and target block
        // Allowing us to calculate the average seconds per block between
        // the two points
        uint256 dBlock = 0;
        uint256 dTime = 0;
        if (epoch < maxEpoch) {
            Point memory point1 = pointHistory[epoch + 1];
            dBlock = point1.blk - point0.blk;
            dTime = point1.ts - point0.ts;
        } else {
            dBlock = block.number - point0.blk;
            dTime = block.timestamp - point0.ts;
        }
        // (Deterministically) Estimate the time at which block _blockNumber was mined
        uint256 blockTime = point0.ts;
        if (dBlock != 0) {
            blockTime =
                blockTime +
                ((dTime * (_blockNumber - point0.blk)) / dBlock);
        }
        // Current Bias = most recent bias - (slope * time since update)
        upoint.bias =
            upoint.bias -
            (upoint.slope * SafeCast.toInt128(int256(blockTime - upoint.ts)));
        if (upoint.bias >= 0) {
            return SafeCast.toUint256(upoint.bias);
        } else {
            return 0;
        }
    }

    /**
     * @dev Calculate current total supply of voting power
     * @return Current totalSupply
     */
    function totalSupply() public view override returns (uint256) {
        uint256 epoch_ = globalEpoch;
        Point memory lastPoint = pointHistory[epoch_];
        return _supplyAt(lastPoint, block.timestamp);
    }

    /**
     * @dev Calculate total supply of voting power at a given blockNumber
     * @param _blockNumber Block number at which to calculate total supply
     * @return totalSupply of voting power at the given blockNumber
     */
    function totalSupplyAt(uint256 _blockNumber)
        public
        view
        override
        returns (uint256)
    {
        require(_blockNumber <= block.number, "Only past block number");

        uint256 epoch = globalEpoch;
        uint256 targetEpoch = _findBlockEpoch(_blockNumber, epoch);

        Point memory point = pointHistory[targetEpoch];

        // If point.blk > _blockNumber that means we got the initial epoch & contract did not yet exist
        if (point.blk > _blockNumber) {
            return 0;
        }

        uint256 dTime = 0;
        if (targetEpoch < epoch) {
            Point memory pointNext = pointHistory[targetEpoch + 1];
            if (point.blk != pointNext.blk) {
                dTime =
                    ((_blockNumber - point.blk) * (pointNext.ts - point.ts)) /
                    (pointNext.blk - point.blk);
            }
        } else if (point.blk != block.number) {
            dTime =
                ((_blockNumber - point.blk) * (block.timestamp - point.ts)) /
                (block.number - point.blk);
        }
        // Now dTime contains info on how far are we beyond point
        return _supplyAt(point, point.ts + dTime);
    }


    /** 
     * ======================================================================================
     * 
     *     CORE LOCK MANAGEMENT
     * 
     * ======================================================================================
     */
    
    /**
     * @dev Deposits or creates a stake for a given address
     * @param _addr User address to assign the stake
     * @param _value Total units of StakingToken to lockup
     * @param _unlockTime Time at which the stake should unlock
     * @param _oldLocked Previous amount staked by this user
     * @param _action See LockAction enum
     */
    function _depositFor(
        address _addr,
        uint256 _value,
        uint256 _unlockTime,
        LockedBalance memory _oldLocked,
        LockAction _action
    ) internal {
        LockedBalance memory newLocked = LockedBalance({
            amount: _oldLocked.amount,
            end: _oldLocked.end
        });

        // Adding to existing lock, or if a lock is expired - creating a new one
        newLocked.amount = newLocked.amount + SafeCast.toInt128(int256(_value));
        if (_unlockTime != 0) {
            newLocked.end = _unlockTime;
        }
        locked[_addr] = newLocked;

        // Possibilities:
        // Both _oldLocked.end could be current or expired (>/< block.timestamp)
        // value == 0 (extend lock) or value > 0 (add to lock or extend lock)
        // newLocked.end > block.timestamp (always)
        _checkpoint(_addr, _oldLocked, newLocked);

        emit Locked(_addr, _value, newLocked.end, _action, block.timestamp);
    }
   
    /**
     * @dev Records a checkpoint of both individual and global slope
     * @param _addr User address, or address(0) for only global
     * @param _oldLocked Old amount that user had locked, or null for global
     * @param _newLocked new amount that user has locked, or null for global
     */
     function _checkpoint(
        address _addr,
        LockedBalance memory _oldLocked,
        LockedBalance memory _newLocked
    ) internal {
        Point memory userOldPoint;
        Point memory userNewPoint;
        int128 oldSlopeDelta = 0;
        int128 newSlopeDelta = 0;
        uint256 epoch = globalEpoch;

        if (_addr != address(0)) {
            // Calculate slopes and biases
            // Kept at zero when they have to
            if (_oldLocked.end > block.timestamp && _oldLocked.amount  > 0) {
                userOldPoint.slope = _oldLocked.amount / SafeCast.toInt128(int256(MAXTIME));
                userOldPoint.bias =
                    userOldPoint.slope *
                    SafeCast.toInt128(int256(_oldLocked.end - block.timestamp));
            }
            if (_newLocked.end > block.timestamp && _newLocked.amount  > 0) {
                userNewPoint.slope = _newLocked.amount / SafeCast.toInt128(int256(MAXTIME));
                userNewPoint.bias =
                    userNewPoint.slope *
                    SafeCast.toInt128(int256(_newLocked.end - block.timestamp));
            }

            // Moved from bottom final if statement to resolve stack too deep err
            // start {
            // Now handle user history
            uint256 uEpoch = userPointEpoch[_addr];
            if (uEpoch == 0) {
                userPointHistory[_addr][uEpoch + 1] = userOldPoint;
            }

            userPointEpoch[_addr] = uEpoch + 1;
            userNewPoint.ts = block.timestamp;
            userNewPoint.blk = block.number;
            userPointHistory[_addr][uEpoch + 1] = userNewPoint;

            // } end

            // Read values of scheduled changes in the slope
            // oldLocked.end can be in the past and in the future
            // newLocked.end can ONLY by in the FUTURE unless everything expired: than zeros
            oldSlopeDelta = slopeChanges[_oldLocked.end];
            if (_newLocked.end != 0) {
                if (_newLocked.end == _oldLocked.end) {
                    newSlopeDelta = oldSlopeDelta;
                } else {
                    newSlopeDelta = slopeChanges[_newLocked.end];
                }
            }
        }

        Point memory lastPoint =
            Point({
                bias: 0,
                slope: 0,
                ts: block.timestamp,
                blk: block.number
            });
        if (epoch > 0) {
            lastPoint = pointHistory[epoch];
        }
        uint256 lastCheckpoint = lastPoint.ts;

        // initialLastPoint is used for extrapolation to calculate block number
        // (approximately, for *At methods) and save them
        // as we cannot figure that out exactly from inside the contract
        Point memory initialLastPoint =
            Point({ bias: 0, slope: 0, ts: lastPoint.ts, blk: lastPoint.blk });
        uint256 blockSlope = 0; // dblock/dt
        if (block.timestamp > lastPoint.ts) {
            blockSlope =
                (MULTIPLIER * (block.number - lastPoint.blk)) /
                (block.timestamp - lastPoint.ts);
        }
        // If last point is already recorded in this block, slope=0
        // But that's ok b/c we know the block in such case

        // Go over weeks to fill history and calculate what the current point is
        uint256 iterativeTime = _floorToWeek(lastCheckpoint);
        for (uint256 i = 0; i < 255; i++) {
            // Hopefully it won't happen that this won't get used in 5 years!
            // If it does, users will be able to withdraw but vote weight will be broken
            iterativeTime = iterativeTime + WEEK;
            int128 dSlope = 0;
            if (iterativeTime > block.timestamp) {
                iterativeTime = block.timestamp;
            } else {
                dSlope = slopeChanges[iterativeTime];
            }

            int128 biasDelta = lastPoint.slope * SafeCast.toInt128(int256((iterativeTime - lastCheckpoint)));
            lastPoint.bias = lastPoint.bias - biasDelta;
            lastPoint.slope = lastPoint.slope + dSlope;

            // This can happen
            if (lastPoint.bias < 0) {
                lastPoint.bias = 0;
            }

            // This cannot happen - just in case
            if (lastPoint.slope < 0) {
                lastPoint.slope = 0;
            }
            lastCheckpoint = iterativeTime;
            lastPoint.ts = iterativeTime;
            lastPoint.blk =
                initialLastPoint.blk +
                (blockSlope * (iterativeTime - initialLastPoint.ts)) /
                MULTIPLIER;

            // when epoch is incremented, we either push here or after slopes updated below
            epoch = epoch + 1;
            if (iterativeTime == block.timestamp) {
                lastPoint.blk = block.number;
                break;
            } else {
                pointHistory[epoch] = lastPoint;
            }
        }

        globalEpoch = epoch;
        // Now pointHistory is filled until t=now

        if (_addr != address(0)) {
            // If last point was in this block, the slope change has been applied already
            // But in such case we have 0 slope(s)
            lastPoint.slope = lastPoint.slope + userNewPoint.slope - userOldPoint.slope;
            lastPoint.bias = lastPoint.bias + userNewPoint.bias - userOldPoint.bias;
            if (lastPoint.slope < 0) {
                lastPoint.slope = 0;
            }
            if (lastPoint.bias < 0) {
                lastPoint.bias = 0;
            }
        }

        // Record the changed point into history
        pointHistory[epoch] = lastPoint;

        if (_addr != address(0)) {
            // Schedule the slope changes (slope is going down)
            // We subtract new_user_slope from [new_locked.end]
            // and add old_user_slope to [old_locked.end]
            if (_oldLocked.end > block.timestamp) {
                // oldSlopeDelta was <something> - userOldPoint.slope, so we cancel that
                oldSlopeDelta = oldSlopeDelta + userOldPoint.slope;
                if (_newLocked.end == _oldLocked.end) {
                    oldSlopeDelta = oldSlopeDelta - userNewPoint.slope; // It was a new deposit, not extension
                }
                slopeChanges[_oldLocked.end] = oldSlopeDelta;
            }
            if (_newLocked.end > block.timestamp) {
                if (_newLocked.end > _oldLocked.end) {
                    newSlopeDelta = newSlopeDelta - userNewPoint.slope; // old slope disappeared at this point
                    slopeChanges[_newLocked.end] = newSlopeDelta;
                }
                // else: we recorded it already in oldSlopeDelta
            }
        }
    }

  
    /** 
     * ======================================================================================
     * 
     *     INTERNAL HELPER FUNCTIONS
     * 
     * ======================================================================================
     */
    /**
     * @dev Floors a timestamp to the nearest weekly increment
     * @param ——t Timestamp to floor
     */
    function _floorToWeek(uint256 _t) internal pure returns (uint256) {
        return (_t / WEEK) * WEEK;
    }

    /**
     * @dev Uses binarysearch to find the most recent point history preceeding block
     * @param _block Find the most recent point history before this block
     * @param _maxEpoch Do not search pointHistories past this index
     */
    function _findBlockEpoch(uint256 _block, uint256 _maxEpoch)
        internal
        view
        returns (uint256)
    {
        // Binary search
        uint256 min = 0;
        uint256 max = _maxEpoch;
        // Will be always enough for 128-bit numbers
        for (uint256 i = 0; i < 128; i++) {
            if (min >= max) break;
            uint256 mid = (min + max + 1) / 2;
            if (pointHistory[mid].blk <= _block) {
                min = mid;
            } else {
                max = mid - 1;
            }
        }
        return min;
    }

    /**
     * @dev Uses binarysearch to find the most recent user point history preceeding block
     * @param _addr User for which to search
     * @param _block Find the most recent point history before this block
     */
    function _findUserBlockEpoch(address _addr, uint256 _block)
        internal
        view
        returns (uint256)
    {
        uint256 min = 0;
        uint256 max = userPointEpoch[_addr];
        for (uint256 i = 0; i < 128; i++) {
            if (min >= max) {
                break;
            }
            uint256 mid = (min + max + 1) / 2;
            if (userPointHistory[_addr][mid].blk <= _block) {
                min = mid;
            } else {
                max = mid - 1;
            }
        }
        return min;
    }

    
    /**
     * @notice Calculate total supply of voting power at a given time _t
     * @param _point Most recent point before time _t
     * @param _t Time at which to calculate supply
     * @return totalSupply at given point in time
     */
    function _supplyAt(Point memory _point, uint256 _t)
        internal
        view
        returns (uint256)
    {
        Point memory lastPoint = _point;
        // Floor the timestamp to weekly interval
        uint256 iterativeTime = _floorToWeek(lastPoint.ts);
        // Iterate through all weeks between _point & _t to account for slope changes
        for (uint256 i = 0; i < 255; i++) {
            iterativeTime = iterativeTime + WEEK;
            int128 dSlope = 0;
            // If week end is after timestamp, then truncate & leave dSlope to 0
            if (iterativeTime > _t) {
                iterativeTime = _t;
            }
            // else get most recent slope change
            else {
                dSlope = slopeChanges[iterativeTime];
            }

            lastPoint.bias =
                lastPoint.bias -
                (lastPoint.slope * SafeCast.toInt128(int256(iterativeTime - lastPoint.ts)));
            if (iterativeTime == _t) {
                break;
            }
            lastPoint.slope = lastPoint.slope + dSlope;
            lastPoint.ts = iterativeTime;
        }

        if (lastPoint.bias < 0) {
            lastPoint.bias = 0;
        }
        return SafeCast.toUint256(lastPoint.bias);
    }

    /**
     * ======================================================================================
     * 
     *     CONTRACT EVENTS
     *
     * ======================================================================================
     */
    event Locked (
        address indexed provider,
        uint256 value,
        uint256 locktime,
        LockAction indexed action,
        uint256 ts
    );

    event Unlocked(
        address indexed provider,
        uint256 value,
        uint256 ts
    );
}