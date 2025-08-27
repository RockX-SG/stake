// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

interface IStaking {
    function checkDebt(uint256 index) external view returns (address account, uint256 amount);
    function currentReserve() external view returns (uint256);
    function currentReserveLegacy() external view returns (uint256);
    function debtOf(address account) external view returns (uint256);
    function ethDepositContract() external view returns (address);
    function exchangeRatio() external view returns (uint256);
    function getAccountedBalance() external view returns (int256);
    function getAccountedManagerRevenue() external view returns (uint256);
    function getAccountedUserRevenue() external view returns (uint256);
    function getCurrentDebts() external view returns (uint256);
    function getDebtQueue() external view returns (uint256 first, uint256 last);
    function getNextValidatorId() external view returns (uint256);
    function getPendingEthers() external view returns (uint256);
    function getQuota(address account) external view returns (uint256);
    function getRecentReceived() external view returns (uint256);
    function getRecentStopped() external view returns (uint256);
    function getRegisteredValidators(uint256 idx_from, uint256 idx_to)
        external
        view
        returns (bytes[] memory pubkeys, bytes[] memory signatures, bool[] memory stopped);
    function getRegisteredValidatorsCount() external view returns (uint256);
    function getRegisteredValidatorsV2(uint256 idx_from, uint256 idx_to)
        external
        view
        returns (bytes[] memory pubkeys, bytes[] memory signatures, bool[] memory stopped, bool[] memory restaking);
    function getReportedValidatorBalance() external view returns (uint256);
    function getReportedAddedStake() external view returns (uint256);
    function getRewardDebts() external view returns (uint256);
    function getRoleAdmin(bytes32 role) external view returns (bytes32);
    function getStoppedValidatorsCount() external view returns (uint256);
    function getTotalStaked() external view returns (uint256);
    function getVectorClock() external view returns (bytes32);
    function instantSwap(uint256 tokenAmount) external;
    function managerFeeShare() external view returns (uint256);
    function mint(uint256 minToMint, uint256 deadline) external returns (uint256 minted);
    function pushBeacon() external;
    function previewInstantSwap(uint256 tokenAmount)
        external
        view
        returns (uint256 maxEthersToSwap, uint256 maxTokensToBurn);
    function redeemContract() external view returns (address);
    function redeemFromValidators(uint256 ethersToRedeem, uint256 maxToBurn, uint256 deadline)
        external
        payable
        returns (uint256 burned);

    function redeemFromValidatorsFee(uint256 ethersToRedeem, uint256 maxToBurn, uint256 deadline)
        external
        view
        returns (uint256, uint256, uint256);
    function restakingContract() external view returns (address);
    function stake() external;
    function syncBalance() external;
    function withdrawalCredentials() external view returns (bytes32);
    function xETHAddress() external view returns (address);
}
