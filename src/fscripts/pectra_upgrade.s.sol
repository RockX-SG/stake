// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {Staking as StakingV1} from "../contracts/staking.sol";

contract PectraUpgrade is Script {
    //forge script fscripts/pectra_upgrade.s.sol --sig 'deploy()' --rpc-url $RPC_ETH --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_SCAN --etherscan-api-key $KEY_ETH_SCAN --delay 30
    function deploy() external {
        vm.startBroadcast();
        StakingV1 stakingV1Impl = new StakingV1();
        vm.stopBroadcast();
        console.log("stakingV1 upgrade implementation to: %s", address(stakingV1Impl));
    }
}
