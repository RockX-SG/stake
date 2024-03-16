from brownie import *
from pathlib import Path

import time
import pytest

'''
Polygon Mumbai Testnet 80001
cBridge: 0x841ce48F9446C8E281D3F1444cB859b4A6D0738C

MessageBus: 0x7d43AABC515C356145049227CeE54B608342c0ad

BSC Testnet 97
cBridge: 0xf89354F314faF344Abd754924438bA798E306DF2

MessageBus: 0xAd204986D6cB67A5Bc76a3CB8974823F43Cb9AAA
'''
def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0x7d43AABC515C356145049227CeE54B608342c0ad"
    receiver = "0x733a6c29eDA4a58931AE81b8d91e29f2EAf01df3"
    wethContract = "0x39d22B78A7651A76Ffbde2aaAB5FD92666Aca520"
    dstChainId = 97 # bsc testnet

    sender = CelerMinterSender.deploy(
            messageBus,
            wethContract,
            receiver,
            dstChainId,
            False,
            {'from': deployer})
