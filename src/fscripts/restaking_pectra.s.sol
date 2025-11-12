// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {
    TransparentUpgradeableProxy,
    ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Restaking, PodOwner} from "../contracts/restaking_pectra.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract RestakingDeploy is Script {
    //forge script fscripts/restaking_pectra.s.sol --sig 'deploy(address,address,address,address,address)' $PROXY_ADMIN_ADDRESS $EIGENPOD_MANAGER_ADDRESS $DELEGATION_MANAGER_ADDRESS $STAKING_PECTRA_ADDRESS $REWARDS_COORDINATOR_ADDRESS --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy(
        address proxyAdmin,
        address eigenpodManager,
        address delegationManager,
        address stakingPectra,
        address rewardsCoordinator
    ) external {
        vm.startBroadcast();
        Restaking implementation = new Restaking();
        TransparentUpgradeableProxy restakingProxy = new TransparentUpgradeableProxy(
            address(implementation),
            proxyAdmin,
            abi.encodeCall(
                Restaking.initialize, (eigenpodManager, delegationManager, stakingPectra, rewardsCoordinator)
            )
        );
        vm.stopBroadcast();
        console.log("restaking_pectra proxy deployed at: %s", address(restakingProxy));
    }

    //forge script fscripts/restaking_pectra.s.sol --sig 'upgrade()' \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function upgrade() external {
        vm.startBroadcast();
        Restaking implementation = new Restaking();
        ProxyAdmin proxyAdmin = ProxyAdmin(0x17C3B688BaDD6dd11244096A9FBc4ae0ADd551ab);
        ITransparentUpgradeableProxy stakingProxy =
            ITransparentUpgradeableProxy(0x4940eE4f0Ff6dAb57Db44Cd71683Aab0ae9cf2c4);
        proxyAdmin.upgrade(stakingProxy, address(implementation));
        vm.stopBroadcast();
    }

    //forge script fscripts/restaking_pectra.s.sol --sig 'upgradePodOwner()' \
    //--account $DEPLOYER --broadcast  --rpc-url $RPC_ETH_HOODI
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function upgradePodOwner() external {
        vm.startBroadcast();
        PodOwner defaultBeaconImpl = new PodOwner();
        Restaking re = Restaking(payable(address(0x4940eE4f0Ff6dAb57Db44Cd71683Aab0ae9cf2c4)));
        re.upgradeBeacon(address(defaultBeaconImpl));
        vm.stopBroadcast();
    }
}
