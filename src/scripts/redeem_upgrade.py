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
    redeem_proxy = '0x98169228cB99Ed26c1043eD8Ca53A5Cb371D3B8D'

    deployer = accounts.load('mainnet-deployer')
    owner = accounts.load('mainnet-owner')

    # simulate redeem upgrade
    redeem_contract = Redeem.deploy( {'from': deployer})
    transparent_redeem = Contract.from_abi("Redeem",redeem_proxy, Redeem.abi)
    proxy_admin_contract.upgrade(redeem_proxy, redeem_contract, {'from': gnosis_safe})
   
    #
