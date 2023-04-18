from brownie import *
from brownie.convert import EthAddress
from pathlib import Path

import time
import pytest

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

    ve_contract = VotingEscrow.deploy(
            {'from': deployer})

    ve_proxy =  TransparentUpgradeableProxy.deploy(
            ve_contract, deployer, b'',
            {'from': deployer})

    transparent_token = Contract.from_abi("BedrockDAO", token_proxy.address, BedrockDAO.abi)
    transparent_token.initialize({'from': owner})

    transparent_ve = Contract.from_abi("VotingEscrow", ve_proxy.address, VotingEscrow.abi)
    transparent_ve.initialize( "voting-escrow BDR", "veBDR", transparent_token, {'from': owner})

    print("VE ADDRESS:", transparent_ve)

    for i in range(2,4):
        print("mint BRT token to: ", accounts[i])
        transparent_token.mint(accounts[i], 100 * 1e18, {'from':owner})
        print("approve BRT token to veBDR")
        transparent_token.approve(transparent_ve, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, {'from':accounts[i]})
        print("lock 100 * 1e18 value of account", accounts[i], "for 30 days:")
        transparent_ve.createLock(100 * 1e18, chain.time() + 86400 * 30, {'from': accounts[i]})
        print("lockinfo:", transparent_ve.userPointHistory(accounts[i], transparent_ve.userPointEpoch(accounts[i])))
        print("balanceOf", accounts[i], "is:", transparent_ve.balanceOf(accounts[2]))
        print("totalSupply is:", transparent_ve.totalSupply())


