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
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";

/// @title GaugeController
/// @notice This contract is the solidity version of curves GaugeController.
contract GaugeController is AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    bytes32 public constant AUTHORIZED_OPERATOR = keccak256("AUTHORIZED_OPERATOR_ROLE");

    struct Point {
        uint256 bias;
        uint256 slope;
    }

    struct VoteData {
        uint256 slope;
        uint256 power;
        uint256 end;
        uint256 voteTime;
    }

    struct GaugeData {
        uint128 gType; // Gauge type
        address bribe; // Bribe contract for the gauge (# Deprecated)
        uint256 wtUpdateTime; // latest weight schedule time
        uint256 w0; // base weight for the gauge.
    }

    uint256 public constant MULTIPLIER = 1e18;
    uint256 public constant WEEK = 604800;
    uint256 public constant PREC = 10000;
    uint256 constant MAX_NUM = 1e9;
    uint256 constant MAX_NUM_GAUGES = 1e4;
    // # Cannot change weight votes more often than once in 6 days
    uint256 public constant WEIGHT_VOTE_DELAY = 6 * 86400;
    address public votingEscrow;
    uint128 public nGaugeTypes;
    uint128 public nGauges;
    // last scheduled time;
    uint256 public timeTotal;

    address[] public gauges;
    // type_id -> last scheduled time
    uint256[MAX_NUM] public timeSum;
    // type_id -> time
    uint256[MAX_NUM] public lastTypeWtTime;

    // time -> total weight
    mapping(uint256 => uint256) public totalWtAtTime;

    // user -> gauge_addr -> VoteData
    mapping(address => mapping(address => VoteData)) public userVoteData;
    // Total vote power used by user
    mapping(address => uint256) public userVotePower;

    // gauge_addr => type_id
    mapping(address => GaugeData) public gaugeData;
    // gauge_addr -> time -> Point
    mapping(address => mapping(uint256 => Point)) public gaugePoints;
    // gauge_addr -> time -> slope
    mapping(address => mapping(uint256 => uint256)) public gaugeSlopeChanges;

    // Track gauge name
    mapping(uint128 => string) public typeNames;
    // type_id -> time -> Point
    mapping(uint128 => mapping(uint256 => Point)) public typePoints;
    // type_id -> time -> slope
    mapping(uint128 => mapping(uint256 => uint256)) public typeSlopeChanges;
    // type_id -> time -> type weight
    mapping(uint128 => mapping(uint256 => uint256)) public typeWtAtTime;

    event TypeAdded(string name, uint128 typeId);
    event TypeWeightUpdated(
        uint128 typeId,
        uint256 time,
        uint256 weight,
        uint256 totalWeight
    );
    event GaugeWeightUpdated(
        address indexed gAddr,
        uint256 time,
        uint256 weight,
        uint256 totalWeight
    );
    event GaugeVoted(
        uint256 time,
        address indexed user,
        address indexed gAddr,
        uint256 weight
    );
    event GaugeAdded(address indexed addr, uint128 gType, uint256 weight);
    event OperatorApproved(address indexed operator, bool isApproved);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __AccessControl_init();
        __ReentrancyGuard_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(AUTHORIZED_OPERATOR, msg.sender);
    }

    /// @notice Add gauge type with name `_name` and weight `weight`
    /// @param _typeName Name of gauge type
    /// @param _weight Weight of gauge type
    function addType(string memory _typeName, uint256 _weight)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        uint128 gType = nGaugeTypes;
        typeNames[gType] = _typeName;
        nGaugeTypes = gType + 1;
        if (_weight != 0) {
            _changeTypeWeight(gType, _weight);
        }
        emit TypeAdded(_typeName, gType);
    }

    /// @notice Add gauge `gAddr` of type `gauge_type` with weight `weight`
    /// @param _gAddr Gauge address
    /// @param _gType Gauge type
    /// @param _weight Gauge weight
    function addGauge(
        address _gAddr,
        uint128 _gType,
        uint256 _weight
    ) external onlyRole(AUTHORIZED_OPERATOR) 
    {
        require(_gAddr != address(0), "Invalid address");
        require(_gType < nGaugeTypes, "Invalid gauge type");
        require(gaugeData[_gAddr].gType == 0, "Gauge already registered"); /// @dev can't add the same gauge twice
        require(nGauges < MAX_NUM_GAUGES, "Can't add more gauges");
        gauges.push(_gAddr);
        nGauges += 1;

        uint256 nextTime = _getWeek(block.timestamp + WEEK);

        if (_weight > 0) {
            uint256 typeWeight = _getTypeWeight(_gType);
            uint256 oldSum = _getSum(_gType);
            uint256 oldTotal = _getTotal();

            typePoints[_gType][nextTime].bias = _weight + oldSum;
            timeSum[_gType] = nextTime;
            totalWtAtTime[nextTime] = oldTotal + typeWeight * _weight;
            timeTotal = nextTime;

            gaugePoints[_gAddr][nextTime].bias = _weight;
        }

        if (timeSum[_gType] == 0) {
            timeSum[_gType] = nextTime;
        }
        gaugeData[_gAddr] = GaugeData({
            gType: _gType + 1,
            bribe: address(0), // @note Variable not used any more.
            wtUpdateTime: nextTime,
            w0: _weight
        });

        emit GaugeAdded(_gAddr, _gType, _weight);
    }

    /// @notice Change gauge type `_gType` weight to `_weight`
    /// @param _gType Gauge type id
    /// @param _weight New Gauge weight
    function changeTypeWeight(uint128 _gType, uint256 _weight)
        external
        onlyRole(DEFAULT_ADMIN_ROLE) 
    {
        _changeTypeWeight(_gType, _weight);
    }

    /// @notice Change weight of gauge `_gAddr` to `_weight`
    /// @param _gAddr `GaugeController` contract address
    /// @param _weight New Gauge weight
    function changeGaugeWeight(address _gAddr, uint256 _weight)
        external
        onlyRole(DEFAULT_ADMIN_ROLE) 
    {
        _changeGaugeWeight(_gAddr, _weight);
    }

    /// @notice Checkpoint to fill data common for all gauges
    function checkpoint() external {
        _getTotal();
    }

    /// @notice checkpoints gauge weight for missing weeks
    function checkpointGauge(address _gAddr) external {
        _getWeight(_gAddr);
        _getTotal();
    }

    /// @notice Allocate voting power for changing pool weights
    /// @param _gAddr Gauge which `msg.sender` votes for
    /// @param _userWeight Weight for a gauge in bps (units of 0.01%). Minimal is 0.01%. Ignored if 0
    function voteForGaugeWeight(address _gAddr, uint256 _userWeight)
        external
        nonReentrant
    {
        require(
            _userWeight >= 0 && _userWeight <= PREC,
            "All voting power used"
        );

        // Get user's latest veToken stats
        (, int128 slope,) = IVotingEscrow(votingEscrow).getLastUserPoint(msg.sender);

        uint256 lockEnd = IVotingEscrow(votingEscrow).lockEnd(msg.sender);

        uint256 nextTime = _getWeek(block.timestamp + WEEK);

        require(lockEnd > nextTime, "Lock expires before next cycle");

        // Prepare slopes and biases in memory
        VoteData memory oldVoteData = userVoteData[msg.sender][_gAddr];
        require(
            block.timestamp >= oldVoteData.voteTime + WEIGHT_VOTE_DELAY,
            "Can't vote so often"
        );

        VoteData memory newVoteData = VoteData({
            slope: (SafeCast.toUint256(slope) * _userWeight) / PREC,
            end: lockEnd,
            power: _userWeight,
            voteTime: block.timestamp
        });
        // Check and update powers (weights) used
        _updateUserPower(oldVoteData.power, newVoteData.power);

        _updateScheduledChanges(
            oldVoteData,
            newVoteData,
            nextTime,
            lockEnd,
            _gAddr
        );

        _getTotal();
        userVoteData[msg.sender][_gAddr] = newVoteData;

        emit GaugeVoted(block.timestamp, msg.sender, _gAddr, _userWeight);
    }

    /// @notice Get gauge weight normalized to 1e18 and also fill all the unfilled
    //         values for type and gauge records
    /// @dev Any address can call, however nothing is recorded if the values are filled already
    /// @param _gAddr Gauge address
    /// @param _time Relative weight at the specified timestamp in the past or present
    /// @return Value of relative weight normalized to 1e18
    function gaugeRelativeWeightWrite(address _gAddr, uint256 _time)
        external
        returns (uint256)
    {
        _getWeight(_gAddr);
        _getTotal();
        return _gaugeRelativeWeight(_gAddr, _time);
    }

    function gaugeRelativeWeightWrite(address _gAddr)
        external
        returns (uint256)
    {
        _getWeight(_gAddr);
        _getTotal();
        return _gaugeRelativeWeight(_gAddr, block.timestamp);
    }

    /// @notice Get gauge type for address
    /// @param _gAddr Gauge address
    /// @return Gauge type id
    function gaugeType(address _gAddr) external view returns (uint128) {
        return _getGaugeType(_gAddr);
    }

    /// @notice Gets the bribe contract for gauge.
    /// @dev This is for backward compatibility
    function gaugeBribe(address _gAddr) external view returns (address) {
        return gaugeData[_gAddr].bribe;
    }

    /// @notice Get Gauge relative weight (not more than 1.0) normalized to 1e18
    //         (e.g. 1.0 == 1e18). Inflation which will be received by it is
    //         inflation_rate * relative_weight / 1e18
    /// @param _gAddr Gauge address
    /// @param _time Relative weight at the specified timestamp in the past or present
    /// @return Value of relative weight normalized to 1e18
    function gaugeRelativeWeight(address _gAddr, uint256 _time)
        external
        view
        returns (uint256)
    {
        return _gaugeRelativeWeight(_gAddr, _time);
    }

    function gaugeRelativeWeight(address _gAddr)
        external
        view
        returns (uint256)
    {
        return _gaugeRelativeWeight(_gAddr, block.timestamp);
    }

    /// @notice Get current gauge weight
    /// @dev Gets the gauge weight based on last checkpoint.
    /// @param _gAddr Gauge address
    /// @return Gauge weight
    function getGaugeWeight(address _gAddr) external view returns (uint256) {
        return gaugePoints[_gAddr][gaugeData[_gAddr].wtUpdateTime].bias;
    }

    /// @notice Get the gauge weight at a provided week timestamp.
    /// @param _gAddr Gauge address
    /// @param _time Required week timestamp
    /// @dev _time should be in ((time / WEEK) * WEEK) value.
    /// @return Returns gauge weight for a week.
    function getGaugeWeight(address _gAddr, uint256 _time)
        external
        view
        returns (uint256)
    {
        return _getGaugeWeightReadOnly(_gAddr, _time);
    }

    /// @notice Get the gaugeWeight - w0 (base weight)
    /// @param _gAddr gauge address
    /// @param _time timestamp
    /// @return returns only the vote weight for the gauge.
    function getUserVotesWtForGauge(address _gAddr, uint256 _time)
        external
        view
        returns (uint256)
    {
        return _getGaugeWeightReadOnly(_gAddr, _time) - gaugeData[_gAddr].w0;
    }

    /// @notice Get current type weight
    /// @param _gType Type id
    /// @return Type weight
    function getTypeWeight(uint128 _gType) external view returns (uint256) {
        return typeWtAtTime[_gType][lastTypeWtTime[_gType]];
    }

    /// @notice Get current total (type-weighted) weight
    /// @return Total weight
    function getTotalWeight() external view returns (uint256) {
        return totalWtAtTime[timeTotal];
    }

    /// @notice Get sum of gauge weights per type
    /// @param _gType Type id
    /// @return Sum of gauge weights
    function getWeightsSumPerType(uint128 _gType)
        external
        view
        returns (uint256)
    {
        return typePoints[_gType][timeSum[_gType]].bias;
    }

    /// @notice Returns address of all registered gauges.
    function getGaugeList() external view returns (address[] memory) {
        return gauges;
    }

    /// @notice Fill historic type weights week-over-week for missed check-points
    ///         and return the type weight for the future week
    /// @param _gType Gauge type id
    /// @return Type weight
    function _getTypeWeight(uint128 _gType) private returns (uint256) {
        uint256 t = lastTypeWtTime[_gType];
        if (t > 0) {
            uint256 w = typeWtAtTime[_gType][t];
            for (uint8 i = 0; i < 100; ) {
                if (t > block.timestamp) {
                    lastTypeWtTime[_gType] = t;
                    break;
                }
                t += WEEK;
                typeWtAtTime[_gType][t] = w;
                unchecked {
                    ++i;
                }
            }
            return w;
        }
        return 0;
    }

    /// @notice Fill sum of gauge weights for the same type week-over-week for
    //         missed checkpoints and return the sum for the future week
    /// @param _gType Gauge type id
    /// @return Sum of weights
    function _getSum(uint128 _gType) private returns (uint256) {
        uint256 t = timeSum[_gType];
        if (t > 0) {
            Point memory pt = typePoints[_gType][t];
            for (uint8 i = 0; i < 100; ) {
                if (t > block.timestamp) {
                    timeSum[_gType] = t;
                    break;
                }
                t += WEEK;
                uint256 dBias = pt.slope * WEEK;
                if (pt.bias > dBias) {
                    pt.bias -= dBias;
                    pt.slope -= typeSlopeChanges[_gType][t];
                } else {
                    pt.bias = 0;
                    pt.slope = 0;
                }
                typePoints[_gType][t] = pt;
                unchecked {
                    ++i;
                }
            }
            return pt.bias;
        }
        return 0;
    }

    /// @notice Fill historic total weights week-over-week for missed checkins
    //         and return the total for the future week
    /// @return Total weight
    function _getTotal() private returns (uint256) {
        uint256 t = timeTotal;
        uint128 numTypes = nGaugeTypes;
        if (t > block.timestamp) {
            t -= WEEK;
        }

        // Updating type related data
        for (uint8 i = 0; i < 100; ) {
            if (i == numTypes) break;
            _getSum(i);
            _getTypeWeight(i);
            unchecked {
                ++i;
            }
        }

        uint256 pt = totalWtAtTime[t];

        for (uint256 i = 0; i < 100; ) {
            if (t > block.timestamp) {
                timeTotal = t;
                break;
            }
            t += WEEK;
            pt = 0;

            for (uint128 gType = 0; gType < 100; ) {
                if (gType == numTypes) break;
                uint256 typeSum = typePoints[gType][t].bias;
                uint256 typeWeight = typeWtAtTime[gType][t];
                pt += typeSum * typeWeight;
                unchecked {
                    ++gType;
                }
            }
            totalWtAtTime[t] = pt;
            unchecked {
                ++i;
            }
        }
        return pt;
    }

    /// @notice Fill historic gauge weights week-over-week for missed checkins
    //         and return the total for the future week
    /// @param _gAddr Address of the gauge
    /// @return Gauge weight
    function _getWeight(address _gAddr) private returns (uint256) {
        uint256 t = gaugeData[_gAddr].wtUpdateTime;
        if (t > 0) {
            Point memory pt = gaugePoints[_gAddr][t];
            for (uint8 i = 0; i < 100; ) {
                if (t > block.timestamp) {
                    gaugeData[_gAddr].wtUpdateTime = t;
                    break;
                }
                t += WEEK;
                uint256 dBias = pt.slope * WEEK;
                if (pt.bias > dBias) {
                    pt.bias -= dBias;
                    pt.slope -= gaugeSlopeChanges[_gAddr][t];
                } else {
                    pt.bias = 0;
                    pt.slope = 0;
                }
                gaugePoints[_gAddr][t] = pt;
                unchecked {
                    ++i;
                }
            }
            return pt.bias;
        }
        return 0;
    }

    /// @notice Change type weight
    /// @param _gType Type id
    /// @param _weight New type weight
    function _changeTypeWeight(uint128 _gType, uint256 _weight) private {
        uint256 oldWeight = _getTypeWeight(_gType);
        uint256 oldSum = _getSum(_gType);
        uint256 totalWeight = _getTotal();
        uint256 nextTime = _getWeek(block.timestamp + WEEK);

        totalWeight = totalWeight + (oldSum * _weight) - (oldSum * oldWeight);
        totalWtAtTime[nextTime] = totalWeight;
        typeWtAtTime[_gType][nextTime] = _weight;
        timeTotal = nextTime;
        lastTypeWtTime[_gType] = nextTime;

        emit TypeWeightUpdated(_gType, nextTime, _weight, totalWeight);
    }

    /// @notice Change gauge weight
    /// @param _gAddr Gauge Address
    /// @param _weight for gauge.
    function _changeGaugeWeight(address _gAddr, uint256 _weight) private {
        uint128 gType = _getGaugeType(_gAddr);
        uint256 oldGaugeWeight = _getWeight(_gAddr);
        uint256 oldW0 = gaugeData[_gAddr].w0;
        uint256 typeWeight = _getTypeWeight(gType);
        uint256 oldSum = _getSum(gType);
        uint256 totalWeight = _getTotal();
        uint256 nextTime = _getWeek(block.timestamp + WEEK);

        gaugePoints[_gAddr][nextTime].bias = oldGaugeWeight + _weight - oldW0;
        gaugeData[_gAddr].wtUpdateTime = nextTime;
        gaugeData[_gAddr].w0 = _weight;

        uint256 newSum = oldSum + _weight - oldGaugeWeight;
        typePoints[gType][nextTime].bias = newSum;
        timeSum[gType] = nextTime;

        totalWeight += (newSum - oldSum) * typeWeight;
        totalWtAtTime[nextTime] = totalWeight;
        timeTotal = nextTime;
        emit GaugeWeightUpdated(_gAddr, block.timestamp, _weight, totalWeight);
    }

    /// @notice Update user power.
    /// @param _oldPow current power used.
    /// @param _newPow updated power.
    function _updateUserPower(uint256 _oldPow, uint256 _newPow) private {
        // Check and update powers (weights) used
        uint256 powerUsed = userVotePower[msg.sender];
        powerUsed = powerUsed + _newPow - _oldPow;
        userVotePower[msg.sender] = powerUsed;
        require(powerUsed >= 0 && powerUsed <= PREC, "Power beyond boundaries");
    }

    /// @notice Update the vote data and scheduled slope changes.
    /// @param _oldVoteData user's old vote data.
    /// @param _newVoteData user's new vote data.
    /// @param _nextTime timestamp for next cycle.
    /// @param _lockEnd the expiry ts for user's veToken position.
    /// @param _gAddr address of the gauge.
    function _updateScheduledChanges(
        VoteData memory _oldVoteData,
        VoteData memory _newVoteData,
        uint256 _nextTime,
        uint256 _lockEnd,
        address _gAddr
    ) private {
        uint128 gType = _getGaugeType(_gAddr);

        // Calculate the current bias based on the oldVoteData.
        uint256 old_dt = 0;
        if (_oldVoteData.end > _nextTime) {
            old_dt = _oldVoteData.end - _nextTime;
        }
        uint256 oldBias = _oldVoteData.slope * old_dt;

        // Calculate the new bias.
        uint256 new_dt = _lockEnd - _nextTime;
        uint256 newBias = _newVoteData.slope * new_dt;

        uint256 oldGaugeSlope = gaugePoints[_gAddr][_nextTime].slope;
        uint256 oldTypeSlope = typePoints[gType][_nextTime].slope;

        {
            // restrict scope of below variables (resolves, stack too deep)
            uint256 oldWtBias = _getWeight(_gAddr);
            uint256 oldSumBias = _getSum(gType);
            // Remove old and schedule new slope changes
            // Remove slope changes for old slopes
            // Schedule recording of initial slope for _nextTime.
            gaugePoints[_gAddr][_nextTime].bias =
                _max(oldWtBias + newBias, oldBias) -
                oldBias;
            typePoints[gType][_nextTime].bias =
                _max(oldSumBias + newBias, oldBias) -
                oldBias;
        }

        if (_oldVoteData.end > _nextTime) {
            gaugePoints[_gAddr][_nextTime].slope =
                _max(oldGaugeSlope + _newVoteData.slope, _oldVoteData.slope) -
                _oldVoteData.slope;
            typePoints[gType][_nextTime].slope =
                _max(oldTypeSlope + _newVoteData.slope, _oldVoteData.slope) -
                _oldVoteData.slope;
        } else {
            gaugePoints[_gAddr][_nextTime].slope += _newVoteData.slope;
            typePoints[gType][_nextTime].slope += _newVoteData.slope;
        }

        if (_oldVoteData.end > block.timestamp) {
            // Cancel old slope changes if they still didn't happen
            gaugeSlopeChanges[_gAddr][_oldVoteData.end] -= _oldVoteData.slope;
            typeSlopeChanges[gType][_oldVoteData.end] -= _oldVoteData.slope;
        }

        // Add slope changes for new slopes
        gaugeSlopeChanges[_gAddr][_newVoteData.end] += _newVoteData.slope;
        typeSlopeChanges[gType][_newVoteData.end] += _newVoteData.slope;
    }

    /// @notice Returns the gauge weight based on the last check-pointed data
    /// @param _gAddr Address of the gauge.
    /// @param _time Required timestamp.
    /// @dev Returns weight based on the Week start of the provided time
    /// @return Returns the weight of the gauge.
    function _getGaugeWeightReadOnly(address _gAddr, uint256 _time)
        private
        view
        returns (uint256)
    {
        uint256 lastUpdateTime = gaugeData[_gAddr].wtUpdateTime;

        // Gauge wt is check-pointed for the time stamp
        if (_time <= lastUpdateTime) {
            return gaugePoints[_gAddr][_time].bias;
        }

        // Calculate estimated gauge weight based on lastUpdateTime
        Point memory lastPoint = gaugePoints[_gAddr][lastUpdateTime];
        uint256 delta = lastPoint.slope *
            WEEK *
            ((_time - lastUpdateTime) / WEEK);

        // all the votes have expired
        if (delta > lastPoint.bias) return 0;

        // return the estimated weight.
        return lastPoint.bias - delta;
    }

    /// @notice Get Gauge relative weight (not more than 1.0) normalized to 1e18
    //         (e.g. 1.0 == 1e18). Inflation which will be received by it is
    //         inflation_rate * relative_weight / 1e18
    /// @param _gAddr Gauge address
    /// @param _time Relative weight at the specified timestamp in the past or present
    /// @return Value of relative weight normalized to 1e18
    function _gaugeRelativeWeight(address _gAddr, uint256 _time)
        private
        view
        returns (uint256)
    {
        uint128 gType = _getGaugeType(_gAddr);
        uint256 t = _getWeek(_time);
        uint256 totalWeight = totalWtAtTime[t];

        if (totalWeight > 0) {
            uint256 typeWeight = typeWtAtTime[gType][t];
            uint256 gaugeWeight = gaugePoints[_gAddr][t].bias;
            return (MULTIPLIER * typeWeight * gaugeWeight) / totalWeight;
        }
        return 0;
    }

    /// @notice Gets the gauge type.
    /// @param _gAddr Gauge address.
    /// @return Returns gauge type.
    function _getGaugeType(address _gAddr) private view returns (uint128) {
        uint128 gType = gaugeData[_gAddr].gType;
        require(gType > 0, "Gauge not added");
        return gType - 1;
    }

    /// @notice Get the based on the ts.
    /// @param _ts arbitrary time stamp.
    /// @return returns the 00:00 am UTC for THU after _ts
    function _getWeek(uint256 _ts) private pure returns (uint256) {
        return (_ts / WEEK) * WEEK;
    }

    function _max(uint256 _a, uint256 _b) private pure returns (uint256) {
        if (_a > _b) return _a;
        return _b;
    }
}