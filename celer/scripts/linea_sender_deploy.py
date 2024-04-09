from brownie import *
from pathlib import Path

import time
import pytest

'''
add linea mainnet with brownie:
brownie networks add Linea linea-mainnet host=https://rpc.linea.build explorer=https://lineascan.build name='Linea Official' chainid=1337

'''
def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0x6F2bD3Dec1A8c4459c2acC318881F63A048c7c28" #MessageBus on linea.
    receiver = "0x7C3F1fe22959b4f6aC2Bf2474B3bDf9969465C95" #CelerMinterReceiver on ethereum
    wethContract = "0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f" #weth on linea
    dstChainId = 1

    sender = CelerMinterSender.deploy(
            messageBus,
            wethContract,
            receiver,
            dstChainId,
            True,
            {'from': deployer})
