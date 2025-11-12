// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {RockXETH} from "../contracts/rockx_eth.sol";

contract UniEth is Script {
    //forge script fscripts/rockx_eth.s.sol --sig 'deploy(address)' $PROXY_ADMIN_ADDRESS --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy(address proxyAdmin) external {
        vm.startBroadcast();
        RockXETH implementation = new RockXETH();
        TransparentUpgradeableProxy uniEthProxy = new TransparentUpgradeableProxy(
            address(implementation), proxyAdmin, abi.encodeCall(RockXETH.initialize, ())
        );
        vm.stopBroadcast();
        console.log("uniETH proxy deployed at: %s", address(uniEthProxy));
    }
}
