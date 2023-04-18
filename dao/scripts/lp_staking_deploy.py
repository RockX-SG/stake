from brownie import *
from brownie.convert import EthAddress
from pathlib import Path

import time
import pytest

# this scripts simulates staking a lp token and 
# rewards are deliveried to staking contract instantly, and accounts receives rewards linearly
def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts[0]
    deployer = accounts[1]

    print(f'contract owner account: {owner.address}\n')

    token_contract = BedrockDAO.deploy(
            {'from': deployer})

    token_proxy =  TransparentUpgradeableProxy.deploy(
            token_contract, deployer, b'',
            {'from': deployer})

    lp_token_contract = BedrockDAO.deploy(
            {'from': deployer})

    lp_token_proxy =  TransparentUpgradeableProxy.deploy(
            lp_token_contract, deployer, b'',
            {'from': deployer})

    staking_contract = LPStaking.deploy(
            {'from': deployer})

    staking_proxy =  TransparentUpgradeableProxy.deploy(
            staking_contract, deployer, b'',
            {'from': deployer})
    

    transparent_lp_token = Contract.from_abi("BedrockDAO", lp_token_proxy.address, BedrockDAO.abi)
    transparent_lp_token.initialize({'from': owner})

    transparent_token = Contract.from_abi("BedrockDAO", token_proxy.address, BedrockDAO.abi)
    transparent_token.initialize({'from': owner})

    transparent_staking = Contract.from_abi("LPStaking", staking_proxy.address, LPStaking.abi)
    transparent_staking.initialize(transparent_lp_token, transparent_token, {'from': owner})

    print("BRT ADDRESS:", transparent_token)
    print("LP TOKEN ADDRESS:", lp_token_contract)
    print("LP STAKING ADDRESS:", transparent_staking)

    print("mint LP token to owner")
    transparent_lp_token.mint(owner, 100 * 1e18, {'from':owner})
    print("approve LP token to staking")
    transparent_lp_token.approve(transparent_staking, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, {'from':owner})
    print("deposit LP to staking")
    transparent_staking.deposit(100*1e18, {'from':owner})

    print("mint rewards to transparent_staking")
    transparent_token.mint(transparent_staking, 200 * 1e18, {'from':owner})

    print("calling updateReward()")
    transparent_staking.updateReward({'from':owner})

    print('''transparent_staking.getPendingReward(owner)''', transparent_staking.getPendingReward(owner))
    print("chain.mine(100)", chain.mine(100))
    print('''transparent_staking.getPendingReward(owner)''', transparent_staking.getPendingReward(owner))
    print("reward balance:", transparent_token.balanceOf(owner))
    print("withdraw lp:", transparent_staking.userInfo(owner)[1], transparent_staking.withdraw(transparent_staking.userInfo(owner)[1], {"from":owner}))
    print("havest after withdraw",transparent_staking.havest(transparent_staking.getPendingReward(owner), {'from':owner}))
    print("reward balance:", transparent_token.balanceOf(owner))
    print("LP balance:", transparent_lp_token.balanceOf(owner))

    print('''transparent_staking.getPendingReward(owner)''', transparent_staking.getPendingReward(owner))
    print("deposit LP to staking again")
    transparent_staking.deposit(100*1e18, {'from':owner})

    print('''chain.sleep(86400*7)''')
    chain.sleep(86400*7)
    chain.mine(1)
    print('''transparent_staking.getPendingReward(owner)''', transparent_staking.getPendingReward(owner))
    print("havest")
    transparent_staking.havest(transparent_staking.getPendingReward(owner), {'from':owner})
    print("reward balance:", transparent_token.balanceOf(owner))

