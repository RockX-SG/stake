// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../interfaces/iface.sol";

contract NativeETHMinter {
    address public sender;
    address public WETH;
    constructor(address _sender, address _WETH) {
        sender = _sender;
        WETH = _WETH;
    }

    /**
     * @dev mint native ETH on source chain
     */
    function mint(
        uint256 _amount,
        uint32 _maxSlippage,
        address recipient
    ) external payable {
        require(_amount < msg.value, "INSUFFICIENT_ETHERS");
        uint256 _fees = msg.value - _amount;
        
        // wrap the amount
        IWETH9(WETH).deposit{value:_amount}(); 
        // approve _amount
        IERC20(WETH).approve(sender, _amount);

        // mint with WETH
        ICelerMinterSender(sender).mint{value:_fees}(_amount, _maxSlippage, recipient);
    } 
}
