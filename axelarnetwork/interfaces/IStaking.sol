// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IStaking {
    function exchangeRatio() external view returns (uint256);
    function mint ( uint256 minToMint, uint256 deadline ) external payable returns ( uint256 minted );
}
