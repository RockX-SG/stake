// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Staking} from "../contracts/staking_pectra.sol";

contract StakingPectraDeploy is Script {
    //forge script fscripts/staking_pectra.s.sol --sig 'deploy(address,address,address,address)' $PROXY_ADMIN_ADDRESS $STAKING_CONTRACT_V1 $UNIETH_ADDRESS $REDEEM_ADDRESS \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function deploy(address proxyAdmin, address stakingContractV1, address uniethAddress, address redeemAddress)
        external
    {
        vm.startBroadcast();
        Staking implementation = new Staking();
        TransparentUpgradeableProxy stakingProxy = new TransparentUpgradeableProxy(
            address(implementation),
            proxyAdmin,
            abi.encodeCall(Staking.initialize, (stakingContractV1, uniethAddress, redeemAddress))
        );
        vm.stopBroadcast();
        console.log("staking_pectra proxy deployed at: %s", address(stakingProxy));
    }

    //forge script fscripts/staking_pectra.s.sol --sig 'mint(address,uint256,uint256)' $STAKING_PROXY_ADDRESS $MIN_TO_MINT $DEADLINE \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER
    function mint(address stakingProxy, uint256 minToMint, uint256 deadline) external payable {
        Staking(payable(stakingProxy)).mint{value: 35 ether}(minToMint, deadline);
    }
}
