import pytest
import time
import sys
import brownie
import random

from pathlib import Path
from brownie import convert
from brownie import *
from conftest import deps

""" test of restaking a validator """
def test_restaking(setup_contracts, owner, deployer):
    pubkeys = [0x9739c7d31f92e4f23d8d9fad9396154255cc4644533e5cde6a1ab4f7ad37da15e748a1317f721658302f1cd1f2b234e5]
    sigs = [0xb94da5641c955a3f4620329387010057ab4b5d7344b823a59607d960e8eeeebfe0f8164fac976c4ed97261b991c157d508ec31edc65f93ee1adfda16a25d20c457b247092fab287b3619b66f35277767cfa5a3e83d4499d7fceb690a5007be2d]
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts

    transparent_staking.registerRestakingValidators(pubkeys, sigs, {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == len(pubkeys)
    results = transparent_staking.getRegisteredValidators(0, len(pubkeys))

    # setup restaking deployment
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    restaking_contract = RockXRestaking.deploy( {'from': owner})
    restaking_proxy = TransparentUpgradeableProxy.deploy(
            restaking_contract.address, deployer, b'',
            {'from': deployer})

    #init 
    eigenpod_manager = '0x91E677b07F7AF907ec9a428aafA9fc14a0d3A338'
    delegation_manager = '0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A'
    strategy_manager = '0x858646372CC42E1A627fcE94aa7A7033e7CF075A'
    delayed_withdrawal_router = '0x7Fe7E9CC0F274d2435AD5d56D5fa73E47F6A23D8'
    transparent_restaking = Contract.from_abi("RockXRestaking",restaking_proxy, RockXRestaking.abi)
    transparent_restaking.initialize(eigenpod_manager, delegation_manager, strategy_manager, delayed_withdrawal_router, {'from': owner})

    # set eigenpod to staking contract
    transparent_staking.setRestakingAddress(transparent_restaking.eigenPod(), {'from':owner})
    print("restaking address", transparent_staking.addrRestaking(),transparent_staking.restakingWithdrawalCredentials()) 

    # mint
    transparent_staking.toggleWhiteList(owner, {'from':owner})
    assert transparent_staking.isWhiteListed(owner) == True
    transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '64 ether'})
    assert transparent_staking.getNextValidatorId() == 0
    transparent_staking.stake({'from':owner})
    assert transparent_staking.getNextValidatorId() == 1
