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

    ve_contract = VotingEscrow.deploy(
            {'from': deployer})

    ve_proxy =  TransparentUpgradeableProxy.deploy(
            ve_contract, deployer, b'',
            {'from': deployer})


    transparent_ve = Contract.from_abi("VotingEscrow", ve_proxy.address, VotingEscrow.abi)
    transparent_ve.initialize( "voting-escrow BDR", "veBDR", 18, {'from': owner})

    print("VE ADDRESS:", transparent_ve)

    print("granting AUTHORIZED LOCKER ROLE to owner")
    transparent_ve.grantRole( transparent_ve.AUTHORIZED_LOCKER_ROLE(), owner, {'from': owner})

    print("lock 100 * 1e18 value of account", accounts[2], "for 30 days:")
    transparent_ve.createLock(accounts[2], 100 * 1e18, chain.time() + 86400 * 30, {'from': owner})
    print("lockinfo:", transparent_ve.userPointHistory(accounts[2], transparent_ve.userPointEpoch(accounts[2])))
    print("balanceOf", accounts[2], "is:", transparent_ve.balanceOf(accounts[2]))
    print("totalSupply is:", transparent_ve.totalSupply())

    print("lock 100 * 1e18 value of account", accounts[3], "for 60 days:")
    transparent_ve.createLock(accounts[3],100 * 1e18, chain.time() + 86400 * 60, {'from': owner})
    print("lockinfo:", transparent_ve.userPointHistory(accounts[3], transparent_ve.userPointEpoch(accounts[3])))
    print("balanceOf", accounts[3], "is:", transparent_ve.balanceOf(accounts[3]))
    print("totalSupply is:", transparent_ve.totalSupply())


