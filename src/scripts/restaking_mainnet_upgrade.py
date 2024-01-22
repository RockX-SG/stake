from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    ProxyAdmin = deps.ProxyAdmin

    eigenpod_manager = '0x91E677b07F7AF907ec9a428aafA9fc14a0d3A338'
    delegation_manager = '0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A'
    strategy_manager = '0x858646372CC42E1A627fcE94aa7A7033e7CF075A'
    delayed_withdrawal_router = '0x7Fe7E9CC0F274d2435AD5d56D5fa73E47F6A23D8'

    gnosis_safe = accounts.at('0xAeE017052DF6Ac002647229D58B786E380B9721A', {'force':True})
    proxy_admin_contract = ProxyAdmin.at('0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6')
    staking_proxy = '0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d'
    owner = accounts.load('mainnet-owner')
    deployer = accounts.load('mainnet-deployer')

    accounts[9].transfer(gnosis_safe, '10 ethers')
    accounts[9].transfer(owner, '10 ethers')
    accounts[9].transfer(deployer, '10 ethers')

    # simulate staking upgrade
    staking_contract = RockXStaking.deploy( {'from': deployer})
    proxy_admin_contract.upgrade(staking_proxy, staking_contract, {'from': gnosis_safe})

    # simulate restaking deployment
    restaking_contract = RockXRestaking.deploy( {'from': owner})
    restaking_proxy = TransparentUpgradeableProxy.deploy(
            restaking_contract.address, deployer, b'',
            {'from': deployer})

    #init 
    transparent_restaking = Contract.from_abi("RockXRestaking",restaking_proxy, RockXRestaking.abi)
    transparent_restaking.initialize(eigenpod_manager, delegation_manager, strategy_manager, delayed_withdrawal_router, {'from': owner})
    
    # set eigenpod to staking contract
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy, RockXStaking.abi)
    transparent_staking.setRestakingAddress(transparent_restaking.eigenPod(), {'from':gnosis_safe})
    print("restaking address", transparent_staking.restakingAddress(),transparent_staking.restakingWithdrawalCredentials()) 

    # simulate

