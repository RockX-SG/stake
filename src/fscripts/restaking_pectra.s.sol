// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Restaking} from "../contracts/restaking_pectra.sol";

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
}
