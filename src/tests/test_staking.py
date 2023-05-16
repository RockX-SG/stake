import pytest
import time
import sys
import brownie

from pathlib import Path
from brownie import convert
from brownie import *

""" test of registering a validator """
def test_registerValidator(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerValidator(pubkeys[0], sigs[0], {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[0]))
    assert(results["signatures"][0] == hex(sigs[0]))

""" test of registering validators """
def test_registerValidators(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerValidators(pubkeys, sigs, {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == len(pubkeys)
    results = transparent_staking.getRegisteredValidators(0, len(pubkeys))
    for i in range(len(pubkeys)):
        assert(results["pubkeys"][i] == hex(pubkeys[i]))
        assert(results["signatures"][i] == hex(sigs[i]))

""" test of replacing validators """
def test_replaceValidator(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerValidator(pubkeys[0], sigs[0], {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[0]))
    assert(results["signatures"][0] == hex(sigs[0]))

    # replace
    transparent_staking.replaceValidator(pubkeys[0], pubkeys[1], sigs[1], {'from': owner})
    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[1]))
    assert(results["signatures"][0] == hex(sigs[1]))


""" test of whitelisting """
def test_whiteListing(setup_contracts, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    ''' initially it should be false '''
    assert transparent_staking.isWhiteListed(owner) == False

    ''' minting more than 32 will revert too '''
    with brownie.reverts("USR003"):
        transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '32.1 ether'})

    with brownie.reverts("USR003"):
        transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '64 ether'})

    ''' white list this account, minting should not revert '''
    transparent_staking.toggleWhiteList(owner, {'from':owner})
    assert transparent_staking.isWhiteListed(owner) == True
    transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '64 ether'})

    ''' remove from white list, minting should revert again '''
    transparent_staking.toggleWhiteList(owner, {'from':owner})
    with brownie.reverts("USR003"):
        transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '64 ether'})


