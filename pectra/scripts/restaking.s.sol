// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {
    TransparentUpgradeableProxy,
    ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Restaking, PodOwner} from "../contracts/mocks/restaking.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract RestakingDeploy is Script {
    //forge script fscripts/restaking.s.sol --sig 'deploy(address,address,address,address)' $PROXY_ADMIN_ADDRESS $EIGENPOD_MANAGER_ADDRESS $DELEGATION_MANAGER_ADDRESS $STRATEGY_MANAGER_ADDRESS --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy(address proxyAdmin, address eigenpodManager, address delegationManager, address strategyManager)
        external
    {
        vm.startBroadcast();
        Restaking implementation = new Restaking();
        TransparentUpgradeableProxy restakingProxy = new TransparentUpgradeableProxy(
            address(implementation),
            proxyAdmin,
            abi.encodeCall(Restaking.initialize, (eigenpodManager, delegationManager, strategyManager))
        );
        vm.stopBroadcast();
        console.log("restaking proxy deployed at: %s", address(restakingProxy));
    }

    //forge script fscripts/restaking.s.sol --sig 'upgradeV3(address,address,address)' $PROXY_ADMIN_ADDRESS $RESTAKING_PROXY_ADDRESS $STAKING_ADDRESS--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast
    function upgradeV3(address proxyAdmin, address restakingProxy, address stakingAddress) external {
        vm.startBroadcast();
        Restaking implementation = new Restaking();
        PodOwner podOwnerImplementation = new PodOwner();
        ProxyAdmin(proxyAdmin).upgradeAndCall(
            ITransparentUpgradeableProxy(address(restakingProxy)),
            address(implementation),
            abi.encodeCall(Restaking.initializeV3, (address(podOwnerImplementation), stakingAddress))
        );
        vm.stopBroadcast();
    }
}
