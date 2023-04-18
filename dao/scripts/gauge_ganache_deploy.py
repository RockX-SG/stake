from brownie import *
from brownie.convert import EthAddress
from pathlib import Path

import time
import pytest

def get_week(n=0):
    WEEK = 604800
    this_week = (chain.time() // WEEK) * WEEK
    return this_week + (n * WEEK)

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts[0]
    deployer = accounts[1]
    voter1 = accounts[2]
    voter2 = accounts[3]
    lp_gauge1 = accounts[8]
    lp_gauge2 = accounts[9]

    print(f'contract owner account: {owner.address}\n')

    ve_contract = VotingEscrow.deploy(
            {'from': deployer})

    ve_proxy =  TransparentUpgradeableProxy.deploy(
            ve_contract, deployer, b'',
            {'from': deployer})


    gauge_contract = GaugeController.deploy(
            {'from': deployer})

    gauge_proxy = TransparentUpgradeableProxy.deploy(
            gauge_contract, deployer, b'',
            {'from': deployer})


    transparent_ve = Contract.from_abi("VotingEscrow", ve_proxy.address, VotingEscrow.abi)
    transparent_ve.initialize( "voting-escrow BRT", "veBRT", {'from': owner})

    print("VE ADDRESS:", transparent_ve)

    transparent_gauge= Contract.from_abi("GaugeController", gauge_proxy.address, GaugeController.abi)
    transparent_gauge.initialize(transparent_ve, {'from': owner})

    print("GAUGE ADDRESS:", transparent_gauge)

    print("granting AUTHORIZED LOCKER ROLE to owner")
    transparent_ve.grantRole( transparent_ve.AUTHORIZED_LOCKER_ROLE(), owner, {'from': owner})

    print("lock 100 * 1e18 value of account", voter1, "for 300 days:")
    transparent_ve.createLock(voter1, 100 * 1e18, chain.time() + 86400 * 300, {'from': owner})
    print("lock 100 * 1e18 value of account", voter2, "for 300 days:")
    transparent_ve.createLock(voter2, 100 * 1e18, chain.time() + 86400 * 300, {'from': owner})
    
    print("########## GAUGE CONTROLLER INIT")
    print(r'''addType("LP-TYPE0", 1, {'from':owner})''')
    transparent_gauge.addType("TYPE0", 1, {'from':owner})

    print(r'''addGauge(lp_gauge1, 0, 0, {'from':owner})''', lp_gauge1)
    transparent_gauge.addGauge(lp_gauge1, 0, 0, {'from':owner})
    print(r'''addGauge(lp_gauge2, 0, 0, {'from':owner})''', lp_gauge2)
    transparent_gauge.addGauge(lp_gauge2, 0, 0, {'from':owner})

    print(r'''voteForGaugeWeight(lp_gauge1, 5000, {'from': voter1})''')
    transparent_gauge.voteForGaugeWeight(lp_gauge1, 5000, {'from': voter1})
    print(r'''voteForGaugeWeight(lp_gauge2, 8000, {'from': voter2})''')
    transparent_gauge.voteForGaugeWeight(lp_gauge2, 8000, {'from': voter2})

    print(r'''transparent_gauge.gaugeRelativeWeight(lp_gauge1, get_week(1))''',
            transparent_gauge.gaugeRelativeWeight(lp_gauge1, get_week(1)))
    print(r'''transparent_gauge.gaugeRelativeWeight(lp_gauge2, get_week(1))''',
            transparent_gauge.gaugeRelativeWeight(lp_gauge2, get_week(1)))
