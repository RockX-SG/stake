from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    restaking_proxy = TransparentUpgradeableProxy.at("0x3F4eaCeb930b0Edfa78a1DFCbaE5c5494E6e9850")
    staking_proxy = "0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d"
    deployer = accounts.load('mainnet-deployer')
    owner = accounts.load('mainnet-owner')

    # simulate restaking contract upgrade
    restaking_contract = Restaking.deploy( {'from': deployer})
    impl = PodOwner.deploy({'from':deployer})
    calldata = Restaking[-1].initializeV3.encode_input(impl)
    restaking_proxy.upgradeToAndCall(restaking_contract, calldata, {'from': deployer})
    transparent_restaking = Contract.from_abi("Restaking",restaking_proxy, Restaking.abi)
    transparent_restaking.withdrawBeforeRestaking({'from':owner})
    print("pending:", transparent_restaking.getPendingWithdrawalAmount())
    print("pod:", transparent_restaking.eigenPod())
    print("staking address:", transparent_restaking.stakingAddress())

    transparent_restaking.createPod({'from':owner})
    transparent_restaking.getTotalPods()
    transparent_restaking.getPod(1)
    upgradableBeacon = deps.UpgradeableBeacon.at(transparent_restaking.beacon())
    transparent_restaking.withdrawBeforeRestaking({'from':accounts[0]})
    transparent_restaking.claimDelayedWithdrawals(10000, {'from':accounts[0]})
    newimpl = PodOwner.deploy({'from':accounts[0]})
    transparent_restaking.upgradeBeacon(newimpl, {'from':owner})
    upgradableBeacon.implementation()
