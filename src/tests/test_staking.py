import pytest
import time
import sys

from pathlib import Path
from brownie import convert
from brownie import *

""" test of registering a validator """
def test_registerValidator(setup_contracts, owner):
    transparent_xeth, transparent_staking, transparent_redeem = setup_contracts
    print(transparent_xeth, transparent_staking, transparent_redeem)

    pubkey = 0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db
    sig = 0xa09b4dc28c10063f6e2a9d2ca94b23db029ef618660138898cb827eae227d99ee1c438988d0222ca4229ba85c40add3b045e823fdb7519a36538ff901ab89f311060bcecc517ba683b84009ee3509afbcd25e991ef34112a5a16be44265441eb

    transparent_staking.registerValidator(pubkey, sig,{'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == 1
    results = transparent_staking.getRegisteredValidators(0, 1)
    assert(results[0][0] == hex(pubkey))
    assert(results[1][0] == hex(sig))
