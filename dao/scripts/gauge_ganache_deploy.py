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
    voter = accounts[2]
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
    transparent_ve.initialize( "voting-escrow BDR", "veBDR", {'from': owner})

    print("VE ADDRESS:", transparent_ve)

    transparent_gauge= Contract.from_abi("GaugeController", gauge_proxy.address, GaugeController.abi)
    transparent_gauge.initialize(transparent_ve, {'from': owner})

    print("GAUGE ADDRESS:", transparent_gauge)

    print("granting AUTHORIZED LOCKER ROLE to owner")
    transparent_ve.grantRole( transparent_ve.AUTHORIZED_LOCKER_ROLE(), owner, {'from': owner})

    print("lock 100 * 1e18 value of account", voter, "for 30 days:")
    transparent_ve.createLock(voter, 100 * 1e18, chain.time() + 86400 * 30, {'from': owner})

    print("########## GAUGE CONTROLLER INIT")
    print(r'''transparent_gauge.addType("LP-TYPE0", 1, {'from':owner})''')
    transparent_gauge.addType("LP-TYPE0", 1, {'from':owner})
    print(r'''transparent_gauge.addType("LP-TYPE1", 2, {'from':owner})''')
    transparent_gauge.addType("LP-TYPE1", 2, {'from':owner})

    print(r'''transparent_gauge.addGauge(lp_gauge1, 0, 0, {'from':owner}''', lp_gauge1)
    transparent_gauge.addGauge(lp_gauge1, 0, 0, {'from':owner})
    print(r'''transparent_gauge.addGauge(lp_gauge2, 1, 0, {'from':owner}''', lp_gauge2)
    transparent_gauge.addGauge(lp_gauge2, 1, 0, {'from':owner})

    print(r'''transparent_gauge.voteForGaugeWeight(lp_gauge1, 5000, {'from':accounts[2]})''')
    transparent_gauge.voteForGaugeWeight(lp_gauge1, 5000, {'from': voter})
    print(r'''transparent_gauge.voteForGaugeWeight(lp_gauge2, 5000, {'from':accounts[2]})''')
    transparent_gauge.voteForGaugeWeight(lp_gauge2, 5000, {'from': voter})

    print(transparent_gauge.gaugeRelativeWeight(lp_gauge1, chain.time() + transparent_gauge.WEEK()))
    print(transparent_gauge.gaugeRelativeWeight(lp_gauge2, chain.time() + transparent_gauge.WEEK()))
