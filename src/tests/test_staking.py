import random
import sys
import time
from pathlib import Path

import brownie
import pytest
from brownie import *

import eth_account
import eth_utils
import eth_abi

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
    ''' replacing again should revert '''
    with brownie.reverts("SYS006"):
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

""" test of quota change"""
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

""" test of quota edge"""
def test_quota_edge(setup_contracts, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    ''' edge case'''
    transparent_staking.mint(0, time.time() + 600, {'from':accounts[9], 'value': '32 ether'})
    
    ''' one wei to break the edge'''
    with brownie.reverts("USR003"):
        transparent_staking.mint(0, time.time() + 600, {'from':accounts[9], 'value': 1})

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

""" test of kyc signer minting"""
def test_mintWithSig(setup_contracts, setup_kycsigner_contract, signerPub, signerPrivate, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts
    transparent_staking_kycsigner = setup_kycsigner_contract
   
    assert transparent_staking.isWhiteListed(transparent_staking_kycsigner)
    assert transparent_xeth.balanceOf(owner) == 0
    assert transparent_staking_kycsigner.allowance(owner) == 0

    new_allowance = eth_utils.to_wei(320, 'ether')
    ethers = eth_utils.to_wei(64, 'ether')

    encoded_data = eth_abi.encode(['bytes32', 'uint256', 'address', 'uint256', 'uint256'], [transparent_staking_kycsigner.WHITELIST_MINT_TYPEHASH(), brownie.network.state.Chain().id, owner.address, transparent_staking_kycsigner.nonces(owner), new_allowance])
    # 计算消息哈希
    message_hash = eth_account.messages.encode_defunct(eth_utils.keccak(encoded_data))
    # 签名消息哈希
    signed_message = eth_account.Account.sign_message(message_hash, private_key=signerPrivate)

    transparent_staking_kycsigner.setSigner(signerPub, {'from': owner})
    
    assert transparent_staking_kycsigner.signer() == signerPub
    assert transparent_staking_kycsigner.verifySigner(owner.address, new_allowance, bytes(signed_message.signature))

    totalDeposits = 0
    mint_transaction = transparent_staking_kycsigner.mintWithSig(0, time.time() + 600, new_allowance, bytes(signed_message.signature), {"from": owner, 'value': ethers})
    # Transfer or Minted event
    mint_event = mint_transaction.events["Transfer"]
    totalDeposits += mint_event["value"];
    assert transparent_staking_kycsigner.allowance(owner) == new_allowance - ethers
    assert transparent_xeth.balanceOf(owner) == totalDeposits

    mint_transaction = transparent_staking_kycsigner.mint(0, time.time() + 600, {"from": owner, 'value': ethers})
    mint_event = mint_transaction.events["Transfer"]
    totalDeposits += mint_event["value"];
    assert transparent_staking_kycsigner.allowance(owner) == new_allowance - ethers - ethers
    assert transparent_xeth.balanceOf(owner) == totalDeposits

    transparent_staking_kycsigner.setAllowance(owner, 0, {"from": owner})
    assert transparent_staking_kycsigner.allowance(owner) == 0

    try:
        transparent_staking_kycsigner.mint(0, time.time() + 600, {"from": owner, 'value': ethers})
        assert False, "INSUFFICIENT_ALLOWANCE"
    except Exception as e:
        assert "NEED_KYC_FOR_MORE" in str(e)
    
    # avoid signature reuse
    try:
        transparent_staking_kycsigner.mintWithSig(0, time.time() + 600, new_allowance, bytes(signed_message.signature), {"from": owner, 'value': ethers})
        assert False, "SIGNER_REUSE"
    except Exception as e:
        assert "SIGNER_MISMATCH" in str(e)
    
    assert transparent_staking_kycsigner.allowance(owner) == 0