// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Staking as StakingV1} from "../contracts/staking.sol";
import {IStaking} from "../contracts/interfaces/IStaking.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {RockXETH} from "../contracts/rockx_eth.sol";
import {IAccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

// forge test --match-path ftests/pectra_upgrade.t.sol -f $RPC_ETH
contract PectraUpgradeTest is Test {
    address owner = address(0xAeE017052DF6Ac002647229D58B786E380B9721A);
    ProxyAdmin proxyAdmin = ProxyAdmin(address(0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6));
    StakingV1 stakingV1 = StakingV1(payable(0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d));
    IStaking stakingV2 = IStaking(payable(0xE0240d05Ae9eF703E2b71F3f4Eb326ea1888DEa3));
    RockXETH uniEth = RockXETH(payable(0xF1376bceF0f78459C0Ed0ba5ddce976F1ddF51F4));
    address stakingV2Admin = address(0x8cb37518330014E027396E3ED59A231FBe3B011A);

    function setUp() public {
        vm.startPrank(owner);
        StakingV1 stakingV1Impl = new StakingV1();
        proxyAdmin.upgradeAndCall(
            TransparentUpgradeableProxy(payable(address(stakingV1))),
            address(stakingV1Impl),
            abi.encodeCall(StakingV1.initializeV3, (address(stakingV2)))
        );
        vm.stopPrank();
        address register = address(0x234);
        vm.startPrank(stakingV2Admin);
        IAccessControlUpgradeable(address(stakingV2))
            .grantRole(0xc2979137d1774e40fe2638d355bf7a7b092be4c67f242aad1655e1e27f9df9cc, register);
        vm.stopPrank();

        vm.prank(register);
        bytes[] memory pubkeys = new bytes[](1);
        bytes[] memory signatures = new bytes[](1);
        uint8[] memory podIds = new uint8[](1);
        pubkeys[0] =
        hex"b534600edbfe7c835ac1497e1700430e84f28fa8e5930612e032c77aee4d4746bdc5c1df2de87343de933f5aa427ea78";
        signatures[0] =
            hex"99a1a241f249ce52050b00087438d97d4cdfd1184deec3851fa4143769e6bd31b48de1381c71b14fedc74058605e0a9a14ce75f7996d9bb056f1b75354bce1fb4cf2f79b8034426c7bcb7909c5e9e973b719e1c9845742c5e92b4b3a45c3345a";
        podIds[0] = 0;
        stakingV2.registerRestakingValidators(pubkeys, signatures, podIds);
        vm.stopPrank();
    }

    function testStakingReserve() public {
        uint256 stakingV1CurrentReserve = stakingV1.currentReserve();
        uint256 stakingV2CurrentReserve = stakingV2.currentReserve();
        console.log("stakingV1CurrentReserve", stakingV1CurrentReserve);
        console.log("stakingV2CurrentReserve", stakingV2CurrentReserve);
        console.log("ratio", stakingV1.exchangeRatio());
        vm.startPrank(owner);
        uniEth.setMintable(address(stakingV2), true);
        vm.stopPrank();
        //mint on V2
        address minter = address(0x123);
        vm.deal(minter, 1124 ether);
        console.log("minter on value2", minter.balance);
        vm.startPrank(minter);
        stakingV2.mint{value: 1024 ether}(500 ether, block.timestamp * 2);
        vm.stopPrank();
        uint256 stakingV1CurrentReserveAfterMint = stakingV1.currentReserve();
        uint256 stakingV2CurrentReserveAfterMint = stakingV2.currentReserve();
        console.log("stakingV1CurrentReserveAfterMint", stakingV1CurrentReserveAfterMint);
        console.log("stakingV2CurrentReserveAfterMint", stakingV2CurrentReserveAfterMint);
        console.log("ratio", stakingV2.exchangeRatio());
    }
}
