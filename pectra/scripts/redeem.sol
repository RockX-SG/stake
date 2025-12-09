// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Redeem} from "../contracts/mocks/redeem.sol";

contract RedeemDeploy is Script {
    //forge script fscripts/redeem.s.sol --sig 'deploy(address)' $PROXY_ADMIN_ADDRESS --rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy(address proxyAdmin) external {
        vm.startBroadcast();
        Redeem implementation = new Redeem();
        TransparentUpgradeableProxy redeemProxy =
            new TransparentUpgradeableProxy(address(implementation), proxyAdmin, abi.encodeCall(Redeem.initialize, ()));
        vm.stopBroadcast();
        console.log("redeem proxy deployed at: %s", address(redeemProxy));
    }
}
