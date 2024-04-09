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

    # simple restaking contract upgrade
    restaking_contract = Restaking.deploy( {'from': deployer})
    restaking_proxy.upgradeTo(restaking_contract, {'from': deployer})

    transparent_restaking = Contract.from_abi("Restaking",restaking_proxy, Restaking.abi)
    impl = PodOwner.deploy({'from':deployer})
    transparent_restaking.upgradeBeacon(impl, {'from':owner})

    transparent_staking = Staking.at(staking_proxy)
