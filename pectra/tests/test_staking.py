import pytest
import time
import sys
import brownie
import random

from pathlib import Path
from brownie import convert
from brownie import *

""" test of registering a validator """
def test_registerValidator(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerValidator(pubkeys[0], sigs[0], {'from': owner})
    ''' register again should revert '''
    with brownie.reverts("SYS005"):
        transparent_staking.registerValidator(pubkeys[0], sigs[0], {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[0]))
    assert(results["signatures"][0] == hex(sigs[0]))

""" test of registering validators """
def test_registerValidators(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerValidators(pubkeys, sigs, {'from': owner})
    ''' register again should revert '''
    with brownie.reverts("SYS005"):
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
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[1]))
    assert(results["signatures"][0] == hex(sigs[1]))
    ''' replacing again should revert '''
    with brownie.reverts("SYS006"):
        transparent_staking.replaceValidator(pubkeys[0], pubkeys[1], sigs[1], {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[1]))
    assert(results["signatures"][0] == hex(sigs[1]))

""" test of replacing validators """
def test_replaceValidators(setup_contracts, owner, oldpubkeys, oldsigs, replacepubkeys, replacesigs, restake):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerValidators(oldpubkeys, oldsigs, {'from': owner})
    ''' register again should revert '''
    with brownie.reverts("SYS005"):
        transparent_staking.registerValidators(oldpubkeys, oldsigs, {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == len(oldpubkeys)
    results = transparent_staking.getRegisteredValidatorsV2(0, len(oldpubkeys))
    for i in range(len(oldpubkeys)):
        assert(results["pubkeys"][i] == hex(oldpubkeys[i]))
        assert(results["signatures"][i] == hex(oldsigs[i]))
        assert(results["restaking"][i] == restake)

    # replace
    transparent_staking.replaceValidators(oldpubkeys, replacepubkeys, replacesigs, restake, {'from': owner})
    ''' replacing again should revert '''
    with brownie.reverts("SYS006"):
        transparent_staking.replaceValidators(oldpubkeys, replacepubkeys, replacesigs, restake, {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == len(oldpubkeys)
    results = transparent_staking.getRegisteredValidators(0, len(oldpubkeys))
    for i in range(len(oldpubkeys)):
        assert(results["pubkeys"][i] == hex(replacepubkeys[i]))
        assert(results["signatures"][i] == hex(replacesigs[i]))


""" test of whitelisting """
"""
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
    accounts[9].transfer(owner, "100 ether")
    transparent_staking.toggleWhiteList(owner, {'from':owner})
    with brownie.reverts("USR003"):
        transparent_staking.mint(0, time.time() + 600, {'from':owner, 'allow_revert':True, 'value': '64 ether'})
"""

""" test of quota change"""
"""
def test_quota(setup_contracts, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    ''' random mint to reach the quota '''
    quotaUsed = 0
    while transparent_staking.getQuota(owner) < 32e18:
        ethers = random.randint(1e17, 1e18)
        if ethers + transparent_staking.getQuota(owner) > 32e18:
            with brownie.reverts("USR003"):
                transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': ethers})
            break

        transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': ethers})
        quotaUsed += ethers
    
    assert transparent_staking.getQuota(owner) == quotaUsed
"""

""" test of quota edge"""
"""
def test_quota_edge(setup_contracts, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    ''' edge case'''
    transparent_staking.mint(0, time.time() + 600, {'from':accounts[9], 'value': '32 ether'})
    
    ''' one wei to break the edge'''
    with brownie.reverts("USR003"):
        transparent_staking.mint(0, time.time() + 600, {'from':accounts[9], 'value': 1})
"""


""" test of minting"""
def test_mint(setup_contracts, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts
   
    ''' white list this account ''' 
    transparent_staking.toggleWhiteList(owner, {'from':owner})

    ''' mint until account ethers depleted, randomly ''' 
    totalDeposits = 0
    while owner.balance() >= 1e18:
        ethers = random.randint(1e18, owner.balance())
        totalDeposits += ethers
        transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': ethers})
        
    ''' compare uniETH balance with totalDeposits '''
    assert transparent_xeth.balanceOf(owner) == totalDeposits
    ''' total supply check '''
    assert transparent_xeth.totalSupply() == totalDeposits
    ''' totalPending check '''
    assert transparent_staking.getPendingEthers() == totalDeposits

    ''' approve uniETH to staking for redeeming '''
    transparent_xeth.approve(transparent_staking, totalDeposits, {'from': owner})

    ''' redeem all ethers '''
    while transparent_xeth.balanceOf(owner) >=  32e18:
        transparent_staking.redeemFromValidators('32 ethers', '32 ethers', time.time() + 600, {'from':owner})
     
    ''' make sure remaining uniETH + total debts is equal to totalDeposits ''' 
    assert transparent_xeth.balanceOf(owner) + transparent_staking.debtOf(owner) == totalDeposits 
    assert transparent_staking.debtOf(owner) == transparent_staking.getCurrentDebts()
