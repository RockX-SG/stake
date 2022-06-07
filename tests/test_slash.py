import pytest
import time
import sys

from brownie import *

global transparent_xeth
global transparent_staking
global transparent_redeem


def test_abc(setup):
    transparent_xeth, transparent_staking, transparent_redeem = setup
    print(transparent_staking)
    print(transparent_xeth)

def test_slash(setup):
    transparent_xeth, transparent_staking, transparent_redeem = setup
    user1 = accounts[2]
    oracle = accounts[3]

    # user1 mint 32eth
    transparent_staking.mint(0, time.time() + 600, {'from':user1, 'value': "32 ether"})
    assert transparent_xeth.balanceOf(user1) == '32 ether'

    # grant oracle role    
    transparent_staking.grantRole(transparent_staking.ORACLE_ROLE(), oracle, {'from': accounts[0]})

    # initial push 32 eth
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.pushBeacon(1, '32.1 ether', vectorClock, {'from':oracle})

    # slash left 16 eth, and send back
    oracle.transfer(transparent_staking.address, '16 ethers')
   
    # notify slashed 16.1 ether
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.validatorSlashedStop([0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db],'16 ethers', '16.1 ethers', vectorClock, {'from':oracle})
    assert transparent_staking.getRecentSlashed() == '16.1 ethers' 

    # sync balance
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.syncBalance(vectorClock, {'from':oracle})
    assert transparent_staking.getRecentReceived() == '16 ethers' 

    # push beacon, we need at least 0.1 
    vectorClock = transparent_staking.getVectorClock()
    transparent_staking.pushBeacon(0, '0.1 ether', vectorClock, {'from':oracle})
    assert transparent_staking.getReportedValidatorBalance() == '0.1 ether'
    assert transparent_staking.getRecentSlashed() == 0
    assert transparent_staking.getRecentReceived() == 0

    

