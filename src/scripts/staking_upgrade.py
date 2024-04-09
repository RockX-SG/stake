from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    ProxyAdmin = deps.ProxyAdmin
    
    oracle = accounts.at('0x795fd9Fc54a81c20aef3e47c1a8a25414224E086', {'force':True})
    gnosis_safe = accounts.at('0xAeE017052DF6Ac002647229D58B786E380B9721A', {'force':True})
    operator = accounts.at('0x11Ad6f6224EAAD9a75F5985dD5CbE5C28187e1b7', {'force':True})

    proxy_admin_contract = ProxyAdmin.at('0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6')
    staking_proxy = '0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d'

    deployer = accounts.load('mainnet-deployer')
    owner = accounts.load('mainnet-owner')

    # simulate staking upgrade
    staking_contract = Staking.deploy( {'from': deployer})
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy, Staking.abi)
    transparent_staking.pushBeacon({'from':owner})
    proxy_admin_contract.upgrade(staking_proxy, staking_contract, {'from': gnosis_safe})
   
    # simulate syncBalance
    #transparent_staking.syncBalance({"from":oracle})
    #print("restaking contract constant:", transparent_staking.RESTAKING_CONTRACT())

    # simulate mint
    #transparent_staking.mint(0, time.time() + 600, {'from':accounts[0], 'value': '64 ether'})
