from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    eigenpod_manager = '0x91E677b07F7AF907ec9a428aafA9fc14a0d3A338'
    delegation_manager = '0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A'
    strategy_manager = '0x858646372CC42E1A627fcE94aa7A7033e7CF075A'
    staking_proxy = '0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d'
    delayed_withdrawal_router = '0x7Fe7E9CC0F274d2435AD5d56D5fa73E47F6A23D8'

    owner = accounts.load('mainnet-owner')
    deployer = accounts.load('mainnet-deployer')

    # simulate restaking deployment
    restaking_contract = RockXRestaking.deploy( {'from': owner})
    restaking_proxy = TransparentUpgradeableProxy.deploy(
            restaking_contract.address, deployer, b'',
            {'from': deployer})

    # init 
    transparent_restaking = Contract.from_abi("RockXRestaking",restaking_proxy, RockXRestaking.abi)
    transparent_restaking.initialize(eigenpod_manager, delegation_manager, strategy_manager, delayed_withdrawal_router, {'from': owner})
    print("eigenpod:", transparent_restaking.eigenPod())
