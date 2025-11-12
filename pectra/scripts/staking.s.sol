// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {
    TransparentUpgradeableProxy,
    ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {Staking} from "../contracts/mocks/staking.sol";

contract StakingDeploy is Script {
    //forge script fscripts/staking.s.sol --sig 'deploy(address)' $PROXY_ADMIN_ADDRESS --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy(address proxyAdmin) external {
        vm.startBroadcast();
        Staking implementation = new Staking();
        TransparentUpgradeableProxy stakingProxy =
            new TransparentUpgradeableProxy(address(implementation), proxyAdmin, abi.encodeCall(Staking.initialize, ()));
        vm.stopBroadcast();
        console.log("staking proxy deployed at: %s", address(stakingProxy));
    }

    //forge script fscripts/staking.s.sol --sig 'upgradeV2(address,address,address,address)' $PROXY_ADMIN_ADDRESS $STAKING_PROXY_ADDRESS \
    //$RESTAKING_CONTRACT $UNI_ETH_ADDRESS --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast
    function upgradeV2(address proxyAdmin, address stakingProxy, address restakingContract, address uniEthAddress)
        external
    {
        vm.startBroadcast();
        Staking implementation = new Staking();
        ProxyAdmin(proxyAdmin).upgradeAndCall(
            ITransparentUpgradeableProxy(address(stakingProxy)),
            address(implementation),
            abi.encodeCall(Staking.initializeV2, (restakingContract, uniEthAddress))
        );
        vm.stopBroadcast();
    }

    //forge script fscripts/staking.s.sol --sig 'upgradeV3(address,address,address)' $PROXY_ADMIN_ADDRESS $STAKING_PROXY_ADDRESS \
    //$REDEEM_CONTRACT --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function upgradeV3(address proxyAdmin, address stakingProxy, address redeemContract) external {
        vm.startBroadcast();
        Staking implementation = new Staking();
        ProxyAdmin(proxyAdmin).upgradeAndCall(
            ITransparentUpgradeableProxy(address(stakingProxy)),
            address(implementation),
            abi.encodeCall(Staking.initializeV3, (redeemContract))
        );
        vm.stopBroadcast();
    }

    //forge script fscripts/staking.s.sol --sig 'upgradeV4(address,address,address)' $PROXY_ADMIN_ADDRESS $STAKING_PROXY_ADDRESS \
    //$STAKING_PECTRA --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function upgradeV4(address proxyAdmin, address stakingProxy, address stakingPectra) external {
        vm.startBroadcast();
        Staking implementation = new Staking();
        ProxyAdmin(proxyAdmin).upgradeAndCall(
            ITransparentUpgradeableProxy(address(stakingProxy)),
            address(implementation),
            abi.encodeCall(Staking.initializeV4, (stakingPectra))
        );
        vm.stopBroadcast();
    }
}
