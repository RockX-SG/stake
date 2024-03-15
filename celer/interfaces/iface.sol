// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IBedrockStaking {
    function mint ( uint256 minToMint, uint256 deadline ) external payable returns ( uint256 minted );
    function xETHAddress (  ) external view returns ( address );
}

interface IMintableContract is IERC20 {
    function mint(address account, uint256 amount) external;
    function burn(uint256 amount) external;
    function burnFrom(address account, uint256 amount) external;
}


interface IWETH9 {
    function withdraw(uint wad) external;
    function deposit() external payable;
}

interface ICelerMinterSender {
    function mint( uint256 _amount, uint32 _maxSlippage, address recipient) external payable;
}
