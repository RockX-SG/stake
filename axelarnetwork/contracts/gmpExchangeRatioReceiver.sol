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

import { AxelarExecutable } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/executable/AxelarExecutable.sol';

contract ExchangeRatioReceiver is AxelarExecutable {
    uint256 private exchangeRatio; 
    string public gmpSender;
    event Received(uint256 exchangeRatio);

    constructor(address gateway_, string memory gmpSender_) AxelarExecutable(gateway_) {
        require(bytes(gmpSender_).length == 42,"invalid address string");
        gmpSender = gmpSender_;
    }

    function _execute(
        string calldata sourceChain,
        string calldata sourceAddress,
        bytes calldata payload_
    ) internal override {
        require(keccak256(bytes(sourceAddress)) == keccak256(bytes(gmpSender)), "bad sender");
        exchangeRatio = abi.decode(payload_, (uint256));
        emit Received(exchangeRatio);
    }

    /**
     * @dev return unieth exchange ratio
     */
    function getExchangeRatio() external view returns (uint256) {
        return exchangeRatio;
    }
}