import pytest
import time
import sys

from pathlib import Path
from brownie import convert
from brownie import *

""" test of registering a validator """
def test_registerValidator(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts
    print(transparent_xeth, transparent_staking, transparent_redeem)

    transparent_staking.registerValidator(pubkeys[0], sigs[0], {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results["pubkeys"][0] == hex(pubkeys[0]))
    assert(results["signatures"][0] == hex(sigs[0]))

""" test of registering validators """
def test_registerValidators(setup_contracts, owner, pubkeys, sigs):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts
    print(transparent_xeth, transparent_staking, transparent_redeem)

    transparent_staking.registerValidators(pubkeys, sigs, {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == len(pubkeys)
    results = transparent_staking.getRegisteredValidators(0, len(pubkeys))
    for i in range(len(pubkeys)):
        assert(results["pubkeys"][i] == hex(pubkeys[i]))
        assert(results["signatures"][i] == hex(sigs[i]))
