// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract ProxyAdminDeploy is Script {
    //forge script fscripts/proxy_admin.s.sol --sig 'deploy()' --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy() external {
        vm.startBroadcast();
        ProxyAdmin proxyAdmin = new ProxyAdmin();
        console.log("ProxyAdmin deployed at: %s", address(proxyAdmin));
        vm.stopBroadcast();
    }
}
