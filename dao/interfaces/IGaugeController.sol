// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.9;

interface IGaugeController {
    struct VoteData {
        uint256 slope;
        uint256 power;
        uint256 end;
        uint256 voteTime;
    }

    /// @notice Checkpoint to fill data common for all gauges
    function checkpoint() external;

    /// @notice checkpoints gauge weight for missing weeks
    function checkpointGauge(address _gAddr) external;

    /// @notice Get gauge weight normalized to 1e18 and also fill all the unfilled
    ///         values for type and gauge records
    /// @dev Any address can call, however nothing is recorded if the values are filled already
    /// @param _gAddr Gauge address
    /// @param _time Relative weight at the specified timestamp in the past or present
    /// @return Value of relative weight normalized to 1e18
    function gaugeRelativeWeightWrite(address _gAddr, uint256 _time)
        external
        returns (uint256);

    function gaugeRelativeWeightWrite(address _gAddr)
        external
        returns (uint256);

    /// @notice gets the number of gauge registered with the controller.
    function nGauges() external view returns (uint256);

    /// @notice Get gauge type for address
    /// @param _gAddr Gauge address
    /// @return Gauge type id
    function gaugeType(address _gAddr) external view returns (uint128);

    /// @notice Get Gauge relative weight (not more than 1.0) normalized to 1e18
    ///         (e.g. 1.0 == 1e18). Inflation which will be received by it is
    ///         inflation_rate * relative_weight / 1e18
    /// @param _gAddr Gauge address
    /// @param _time Relative weight at the specified timestamp in the past or present
    /// @return Value of relative weight normalized to 1e18
    function gaugeRelativeWeight(address _gAddr, uint256 _time)
        external
        view
        returns (uint256);

    function gaugeRelativeWeight(address _gAddr)
        external
        view
        returns (uint256);

    /// @notice Get current gauge weight
    /// @param _gAddr Gauge address
    /// @return Gauge weight
    function getGaugeWeight(address _gAddr) external view returns (uint256);

    /// @notice Get the gauge weight at a provided week timestamp.
    /// @param _gAddr Gauge address
    /// @param _time Required week timestamp
    /// @dev _time should be in ((time / WEEK) * WEEK) value.
    /// @return Returns gauge weight for a week.
    function getGaugeWeight(address _gAddr, uint256 _time)
        external
        view
        returns (uint256);

    /// @notice Get the gaugeWeight - w0 (base weight)
    /// @param _gAddr gauge address
    /// @param _time timestamp
    /// @return returns only the vote weight for the gauge.
    function getUserVotesWtForGauge(address _gAddr, uint256 _time)
        external
        view
        returns (uint256);

    /// @notice Get the user's vote data for a gauge.
    /// @param _user Address of the user
    /// @param _gAddr Address of the gauge.
    /// @return Returns VoteData struct.
    function userVoteData(address _user, address _gAddr)
        external
        view
        returns (VoteData memory);
}
