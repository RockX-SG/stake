from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0x3ad9d0648cdaa2426331e894e980d0a5ed16257f"
    receiver = "0x7C3F1fe22959b4f6aC2Bf2474B3bDf9969465C95"
    wethContract = "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1"
    dstChainId = 1

    sender = CelerMinterSender.deploy(
            messageBus,
            wethContract,
            receiver,
            dstChainId,
            True,
            {'from': deployer})
