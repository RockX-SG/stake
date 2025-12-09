// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script, console} from "forge-std/Script.sol";
import {
    TransparentUpgradeableProxy,
    ITransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {Staking} from "../contracts/staking_pectra.sol";
import {PodOwner, Restaking} from "../contracts/restaking_pectra.sol";
import {EigenPod} from "@eigenlayer/contracts/pods/EigenPod.sol";
import {IEigenPodTypes} from "@eigenlayer/contracts/interfaces/IEigenPod.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

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

    //forge script fscripts/staking_pectra.s.sol --sig 'upgrade()' \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function upgrade() external {
        vm.startBroadcast();
        Staking implementation = new Staking();
        ProxyAdmin proxyAdmin = ProxyAdmin(0x17C3B688BaDD6dd11244096A9FBc4ae0ADd551ab);
        ITransparentUpgradeableProxy stakingProxy =
            ITransparentUpgradeableProxy(0x83ED17AAe050335E3d459EF7867672f166d25995);
        proxyAdmin.upgrade(stakingProxy, address(implementation));
        vm.stopBroadcast();
    }

    //forge script scripts/staking_pectra.s.sol --sig 'newStaking()' \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER --broadcast \
    //--verify --verifier-url $RPC_ETH_HOODI_SCAN --etherscan-api-key $KEY_ETH_HOODI_SCAN --delay 30
    function newStaking() external {
        vm.startBroadcast();
        // Deploy new staking contract
        Staking implementation = new Staking();
        // Add any initialization logic here
        console.log("New staking contract deployed at: %s", address(implementation));
        vm.stopBroadcast();
    }

    //forge script fscripts/staking_pectra.s.sol --sig 'mint(address,uint256,uint256)' $STAKING_PROXY_ADDRESS $MIN_TO_MINT $DEADLINE \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER
    function mint(address stakingProxy, uint256 minToMint, uint256 deadline) external payable {
        Staking(payable(stakingProxy)).mint{value: 35 ether}(minToMint, deadline);
    }

    //forge script fscripts/staking_pectra.s.sol --sig 'pushValidatorDebts(address)' $STAKING_PROXY_ADDRESS \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER
    function pushValidatorDebts(address stakingProxy) external {
        Staking.ValidatorDebt[] memory validatorDebts = new Staking.ValidatorDebt[](1);
        bytes memory key =
            hex"b534600edbfe7c835ac1497e1700430e84f28fa8e5930612e032c77aee4d4746bdc5c1df2de87343de933f5aa427ea78";
        validatorDebts[0] = Staking.ValidatorDebt({pubkey: key, amount: 32 ether});
        vm.startBroadcast();
        uint256 withdrawalFee = Staking(payable(stakingProxy)).getWithdrawalFee();
        bytes32 clock = Staking(payable(stakingProxy)).getVectorClock();
        Staking(payable(stakingProxy)).pushValidatorDebts{value: withdrawalFee * 1 ether}(validatorDebts, clock);
        vm.stopBroadcast();
    }

    //forge script fscripts/staking_pectra.s.sol --sig 'podOwnerWithdrawal()' \
    //--rpc-url $RPC_ETH_HOODI --sender $DEPLOYER_ADDRESS \
    //--account $DEPLOYER
    function podOwnerWithdrawal() external {
        address podOwner = 0xB885119212E557C3d7156d992e2fe15640b1BB12;
        Staking.ValidatorDebt[] memory validatorDebts = new Staking.ValidatorDebt[](1);
        bytes memory key =
            hex"b534600edbfe7c835ac1497e1700430e84f28fa8e5930612e032c77aee4d4746bdc5c1df2de87343de933f5aa427ea78";
        validatorDebts[0] = Staking.ValidatorDebt({pubkey: key, amount: 32 ether});
        vm.startBroadcast(podOwner);
        console.log("podOwner: %s", podOwner.balance);
        address pod = 0x53ceb47061DAa07C54f02f64C72E7F8843acB70a;
        // PodOwner owner = PodOwner(payable(podOwner));
        // bytes memory data =
        //     hex"3f5fa57a000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000007735940000000000000000000000000000000000000000000000000000000000000000030b534600edbfe7c835ac1497e1700430e84f28fa8e5930612e032c77aee4d4746bdc5c1df2de87343de933f5aa427ea7800000000000000000000000000000000";
        // owner.executeWithValue(0x53ceb47061DAa07C54f02f64C72E7F8843acB70a, data, 1);
        IEigenPodTypes.WithdrawalRequest[] memory wr = new IEigenPodTypes.WithdrawalRequest[](1);
        wr[0] = IEigenPodTypes.WithdrawalRequest({pubkey: key, amountGwei: 3200000000});
        EigenPod(payable(pod)).requestWithdrawal{value: 1000}(wr);
        // EigenPod(payable(pod)).requestWithdrawal(wr);
        vm.stopBroadcast();
    }

    function poddOwner() external {
        address restaking = 0x4940eE4f0Ff6dAb57Db44Cd71683Aab0ae9cf2c4;
        bytes memory key =
            hex"b534600edbfe7c835ac1497e1700430e84f28fa8e5930612e032c77aee4d4746bdc5c1df2de87343de933f5aa427ea78";
        vm.startBroadcast(0x83ED17AAe050335E3d459EF7867672f166d25995);
        Restaking restakingC = Restaking(payable(restaking));
        IEigenPodTypes.WithdrawalRequest[] memory wr = new IEigenPodTypes.WithdrawalRequest[](1);
        wr[0] = IEigenPodTypes.WithdrawalRequest({pubkey: key, amountGwei: 32000000000});
        restakingC.requestWithdrawal{value: 1}(0, wr);
        vm.stopBroadcast();
    }
}
