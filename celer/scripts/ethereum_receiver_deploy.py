from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0x4066d196a423b2b3b8b054f4f40efb47a74e200c"
    tokenVault = "0x7510792A3B1969F9307F3845CE88e39578f2bAE1" # OriginalTokenVault
    wethContract = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
    tokenContract = "0xF1376bceF0f78459C0Ed0ba5ddce976F1ddF51F4"
    stakingContract = "0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d"

    # deployer receiver
    receiver = CelerMinterReceiver.deploy(
            messageBus,
            tokenVault,
            wethContract,
            stakingContract,
            {'from': deployer})
