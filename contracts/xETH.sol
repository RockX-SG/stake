// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract xETH is ERC20 {
    constructor() ERC20("RockX ETH Token", "xETH") {}
}