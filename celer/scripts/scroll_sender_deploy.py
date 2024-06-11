from brownie import *
from pathlib import Path

import time
import pytest

'''
scroll:
mainnet network-id = 534352
rpc: https://scroll-mainnet.public.blastapi.io
testnet network-id = 534351
rpc: https://scroll-sepolia.public.blastapi.io

add scroll with brownie:
brownie networks add Scroll scroll-mainnet host=https://scroll-mainnet.public.blastapi.io explorer=https://api.scrollscan.com/api name='Scorll Mainnet' chainid=1337

brownie networks add Scroll scroll-testnet host=https://scroll-sepolia.public.blastapi.io explorer=https://api-sepolia.scrollscan.com/api name='Scorll Testnet' chainid=1337

'''
def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0x7d43AABC515C356145049227CeE54B608342c0ad" #MessageBus on scroll.
    receiver = "0x7C3F1fe22959b4f6aC2Bf2474B3bDf9969465C95" #CelerMinterReceiver on ethereum
    wethContract = "0x5300000000000000000000000000000000000004" #weth on scroll
    dstChainId = 1

    sender = CelerMinterSender.deploy(
            messageBus,
            wethContract,
            receiver,
            dstChainId,
            True,
            {'from': deployer})
