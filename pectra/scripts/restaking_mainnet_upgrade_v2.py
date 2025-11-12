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
    restaking_contract = RockXRestaking.deploy( {'from': deployer})
    calldata = RockXRestaking[-1].initializeV2.encode_input("0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d")
    restaking_proxy.upgradeToAndCall(restaking_contract, calldata, {'from': deployer})
    transparent_restaking = Contract.from_abi("RockXRestaking",restaking_proxy, RockXRestaking.abi)
    transparent_restaking.withdrawBeforeRestaking({'from':owner})
    print("pending:", transparent_restaking.getPendingWithdrawalAmount())
    print("pod:", transparent_restaking.eigenPod())
    print("staking address:", transparent_restaking.stakingAddress())
