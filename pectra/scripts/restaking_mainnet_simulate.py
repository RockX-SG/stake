from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    staking_proxy = '0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d'
    owner = accounts.load('mainnet-owner')
    operator = accounts.at('0x11Ad6f6224EAAD9a75F5985dD5CbE5C28187e1b7', {'force':True})
    
    # set eigenpod to staking contract
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy, RockXStaking.abi)

    # simulate
    transparent_staking.mint(0, time.time() + 600, {'from':accounts[0], 'value': '64 ether'})
