// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IStaking {
    function exchangeRatio() external view returns (uint256);
}