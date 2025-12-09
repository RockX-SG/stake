pragma solidity ^0.8.4;

import {Test, console} from "forge-std/Test.sol";

import {
    TransparentUpgradeableProxy,
    ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Staking} from "../contracts/staking_pectra.sol";
import {PodOwner, Restaking} from "../contracts/restaking_pectra.sol";
import {EigenPod} from "@eigenlayer/contracts/pods/EigenPod.sol";
import {IEigenPodTypes} from "@eigenlayer/contracts/interfaces/IEigenPod.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {RockXETH} from "../contracts/mocks/rockx_eth.sol";

// forge test --match-path tests/staking.t.sol -f $RPC_ETH
contract StakingPectraTest is Test {
    address owner = address(0xAeE017052DF6Ac002647229D58B786E380B9721A);
    address pauser = address(0x8cb37518330014E027396E3ED59A231FBe3B011A);
    ProxyAdmin proxyAdmin = ProxyAdmin(address(0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6));
    Staking stakingV2 = Staking(payable(0xE0240d05Ae9eF703E2b71F3f4Eb326ea1888DEa3));
    RockXETH uniEth = RockXETH(payable(0xF1376bceF0f78459C0Ed0ba5ddce976F1ddF51F4));
    address stakingV2Admin = address(0x8cb37518330014E027396E3ED59A231FBe3B011A);

    function setUp() public {
        vm.startPrank(owner);
        Staking stakingImpl = new Staking();
        proxyAdmin.upgrade(ITransparentUpgradeableProxy(address(stakingV2)), address(stakingImpl));
        vm.stopPrank();
    }

    function testStakingReserve() public {
        uint256 stakingV2CurrentReserve = stakingV2.currentReserve();
        console.log("stakingV2CurrentReserve", stakingV2CurrentReserve);
        console.log("ratio", stakingV2.exchangeRatio());
        console.log("redeemEnabled:", stakingV2.redeemEnabled());
        //mint on V2
        address minter = address(0x123);
        vm.deal(minter, 1124 ether);
        console.log("minter on value2", minter.balance);
        vm.startPrank(minter);
        stakingV2.mint{value: 1024 ether}(500 ether, block.timestamp * 2);
        vm.stopPrank();
        uint256 stakingV2CurrentReserveAfterMint = stakingV2.currentReserve();
        console.log("stakingV2CurrentReserveAfterMint", stakingV2CurrentReserveAfterMint);
        console.log("ratio", stakingV2.exchangeRatio());
        vm.startBroadcast(minter);
        vm.expectRevert();
        stakingV2.redeemFromValidators(32 ether, 32 ether, block.timestamp * 2);
        vm.stopBroadcast();
        //open redeem
        vm.prank(pauser);
        stakingV2.redeemEnable();
        vm.stopPrank();
        console.log("redeemEnabled after set:", stakingV2.redeemEnabled());
        vm.startPrank(minter);
        uniEth.approve(address(stakingV2), 32 * 5 ether);
        stakingV2.redeemFromValidators(32 ether, 32 ether, block.timestamp * 2);
        vm.stopPrank();
        //close redeem
        vm.prank(pauser);
        stakingV2.redeemDisable();
        vm.stopPrank();
        console.log("redeemEnabled after set:", stakingV2.redeemEnabled());
        vm.startPrank(minter);
        vm.expectRevert();
        stakingV2.redeemFromValidators(32 ether, 32 ether, block.timestamp * 2);
        vm.stopPrank();
    }
}
