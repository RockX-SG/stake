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

    proxy_admin_contract = ProxyAdmin.at('0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6')
    staking_proxy = '0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d'

    deployer = accounts.load('mainnet-deployer')

    # simulate staking upgrade
    staking_contract = RockXStaking.deploy( {'from': deployer})
    calldata = RockXStaking[-1].initializeV2.encode_input("0x3F4eaCeb930b0Edfa78a1DFCbaE5c5494E6e9850")
    print("upgradeAndCall calldata:", calldata)
    proxy_admin_contract.upgradeAndCall(staking_proxy, staking_contract, calldata, {'from': gnosis_safe})
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy, RockXStaking.abi)
    # simulate mint
    #transparent_staking.mint(0, time.time() + 600, {'from':accounts[0], 'value': '64 ether'})
    #print(transparent_staking.restakingContract())
    #print(transparent_staking.ethDepositContract())
