from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    restaking_proxy = TransparentUpgradeableProxy.at("0x3F4eaCeb930b0Edfa78a1DFCbaE5c5494E6e9850")
    deployer = accounts.load('mainnet-deployer')

    # simulate restaking contract upgrade
    restaking_contract = RockXRestaking.deploy( {'from': deployer})
    restaking_proxy.upgradeTo(restaking_contract,{'from': deployer})
    transparent_restaking = Contract.from_abi("RockXRestaking",restaking_proxy, RockXRestaking.abi)
    print(transparent_restaking.getPendingWithdrawalAmount())
