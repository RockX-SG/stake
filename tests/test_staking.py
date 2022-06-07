import pytest
import time

from brownie import *

def test_mint(setup):
    transparent_xeth, transparent_staking, transparent_redeem = setup
    user1 = accounts[2]
    transparent_xeth.approve(transparent_staking, '100 ether', {'from': user1})
    transparent_staking.mint(0, time.time() + 600, {'from':user1, 'value': "1 ether"})
    assert transparent_staking.exchangeRatio() == 1e18

def test_redeem(setup):
    transparent_xeth, transparent_staking, transparent_redeem = setup
    owner = accounts[0]
    user1 = accounts[2]
    transparent_staking.mint(0, time.time() + 600, {'from':user1, 'value': "32 ether"})
    assert transparent_xeth.balanceOf(user1) == '32 ether'
   
    # initiate redeem and burn xETH
    transparent_xeth.approve(transparent_staking, '100 ether', {'from': user1})
    transparent_staking.redeemFromValidators("32 ether", "32 ether", time.time() + 600, {'from': user1})
    assert transparent_staking.debtOf(user1) == '32 ether'
    assert transparent_staking.exchangeRatio() == 1e18
    assert transparent_xeth.balanceOf(user1) == 0

    # mock 8 ethers received & validator stopped
    assert transparent_staking.debtOf(user1) == '32 ether'
    accounts[4].transfer(transparent_staking.address, '32 ethers')
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.syncBalance(vectorClock, {'from':owner})
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.validatorStopped([0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db],'32 ethers', vectorClock, {'from':owner})
    assert transparent_staking.debtOf(user1) == '0 ether'
    assert transparent_redeem.balanceOf(user1) == '32 ether'

    lastBalance = user1.balance()
    transparent_redeem.claim('8 ether', {'from':user1})
    assert transparent_redeem.balanceOf(user1) == '24 ether' 
    assert user1.balance() - lastBalance == '8 ether'

def test_beacon(setup):
    transparent_xeth, transparent_staking, transparent_redeem = setup
    expectedExchangeRatio = 1009950000000000000 
    # some ethers to redeem
    user1 = accounts[2]

    oracle = accounts[3]
    transparent_staking.mint(0, time.time() + 600, {'from':oracle, 'value': "32 ether"})
    assert transparent_xeth.balanceOf(oracle) == '32 ether'

    transparent_staking.grantRole(transparent_staking.ORACLE_ROLE(), oracle, {'from': accounts[0]})
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.pushBeacon(1, '32.32 ether', vectorClock, {'from':oracle})

    assert transparent_staking.exchangeRatio() == expectedExchangeRatio

