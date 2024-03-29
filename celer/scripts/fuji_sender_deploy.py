from brownie import *
from pathlib import Path

import time
import pytest

'''
Avalanche C-Chain Fuji Testnet 43113
cBridge: 0xe95E3a9f1a45B5EDa71781448F6047d7B7e31cbF

MessageBus: 0xE9533976C590200E32d95C53f06AE12d292cFc47

BSC Testnet 97
cBridge: 0xf89354F314faF344Abd754924438bA798E306DF2

MessageBus: 0xAd204986D6cB67A5Bc76a3CB8974823F43Cb9AAA
'''
def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0xE9533976C590200E32d95C53f06AE12d292cFc47"
    receiver = "0xf1C04C0EC7D2dF56478e2b126Cc94FF736718364"
    wethContract = "0xCD086225f47155937cc57b320f8D37933B683197"
    dstChainId = 97 # bsc testnet

    sender = CelerMinterSender.deploy(
            messageBus,
            wethContract,
            receiver,
            dstChainId,
            False,
            {'from': deployer})
