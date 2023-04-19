from brownie import *
from brownie.convert import EthAddress
from pathlib import Path

import time
import pytest

def get_week(n=0):
    WEEK = 604800
    this_week = (chain.time() // WEEK) * WEEK
    return this_week + (n * WEEK)

# this script simulates voters locks to get veToken
# get rewards based on their ve balance
def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts[0]
    deployer = accounts[1]
    voters = [accounts[2],accounts[3]]

    print(f'contract owner account: {owner.address}\n')

    token_contract = BedrockDAO.deploy(
            {'from': deployer})

    token_proxy =  TransparentUpgradeableProxy.deploy(
            token_contract, deployer, b'',
            {'from': deployer})

    ve_contract = VotingEscrow.deploy(
            {'from': deployer})

    ve_proxy =  TransparentUpgradeableProxy.deploy(
            ve_contract, deployer, b'',
            {'from': deployer})

    ve_rewards_contract = VeRewards.deploy(
            {'from': deployer})

    ve_rewards_proxy = TransparentUpgradeableProxy.deploy(
            ve_rewards_contract, deployer, b'',
            {'from': deployer})

    transparent_token = Contract.from_abi("BedrockDAO", token_proxy.address, BedrockDAO.abi)
    transparent_token.initialize({'from': owner})

    print("BRT ADDRESS:", transparent_token)

    transparent_ve = Contract.from_abi("VotingEscrow", ve_proxy.address, VotingEscrow.abi)
    transparent_ve.initialize( "voting-escrow BRT", "veBRT", transparent_token, {'from': owner})

    print("VE ADDRESS:", transparent_ve)

    transparent_ve_rewards = Contract.from_abi("VeRewards", ve_rewards_proxy.address, VeRewards.abi)
    transparent_ve_rewards.initialize(transparent_ve, transparent_token, {'from': owner})

    print("VE REWARDS ADDRESS:", transparent_ve_rewards)

    for voter in voters: 
        print("minting BRT token to: ", voter)
        transparent_token.mint(voter, 100 * 1e18, {'from':owner})
        print("Approving BRT token to veBRT")
        transparent_token.approve(transparent_ve, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, {'from':voter})
        print("lock 100 * 1e18 value of account", voter, "for 300 days:")
        transparent_ve.createLock(100 * 1e18, chain.time() + 86400 * 300, {'from': voter})

    print("########## MINT REWARDS TO VE_REWARDS #############")
    print('''transparent_token.mint(transparent_ve_rewards, 100000 * 1e18, {'from':owner})''')
    transparent_token.mint(transparent_ve_rewards, 100000 * 1e18, {'from':owner})
    print('''transparent_token.balanceOf(transparent_ve_rewards)''',transparent_token.balanceOf(transparent_ve_rewards))

    lastweek = get_week(0)
    print(''' sleep one week ''')
    chain.sleep(86400*7)
    chain.mine(1)

    for voter in voters: 
        print('''transparent_ve.balanceOf(voter)''',transparent_ve.balanceOfAt(voter, lastweek))
        print('''transparent_ve_rewards.getPendingReward(voter)''',transparent_ve_rewards.getPendingReward(voter))

