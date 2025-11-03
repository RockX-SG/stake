// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {RockXETH} from "../contracts/rockx_eth.sol";
import {
    TransparentUpgradeableProxy
    // ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract RockXETHTest is Test {
    address owner = address(0xAeE017052DF6Ac002647229D58B786E380B9721A);
    RockXETH uniETH = RockXETH(0xF1376bceF0f78459C0Ed0ba5ddce976F1ddF51F4);
    ProxyAdmin proxyAdmin = ProxyAdmin(0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6);

    function setUp() public {
        upgradeToNewImplementation();
    }

    function upgradeToNewImplementation() internal {
        vm.startPrank(owner);
        RockXETH _impl = new RockXETH();
        proxyAdmin.upgrade(TransparentUpgradeableProxy(payable(address(uniETH))), address(_impl));
        vm.stopPrank();
    }

    function testFreeze() public {
        vm.startPrank(owner);

        uniETH.setFreezeToRecipient(owner);

        address[] memory _usersToFreeze = new address[](1);
        _usersToFreeze[0] = address(0xAa760D53541d8390074c61DEFeaba314675b8e3f);
        uniETH.freezeUsers(_usersToFreeze);

        vm.stopPrank();

        vm.startPrank(_usersToFreeze[0]);
        vm.expectRevert("USR016");
        uniETH.transfer(address(0xdeadbeef), 1 ether);

        address[] memory recipients = new address[](2);
        recipients[0] = address(0x1111111111111111111111111111111111111111);
        recipients[1] = address(0x2222222222222222222222222222222222222222);
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 0.5 ether;
        amounts[1] = 0.5 ether;
        vm.expectRevert("USR016");
        uniETH.batchTransfer(recipients, amounts);

        uniETH.transfer(owner, 1 ether);

        vm.stopPrank();
    }
}
