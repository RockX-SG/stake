from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deployer = accounts.load('mainnet-deployer')
    messageBus = "0xAd204986D6cB67A5Bc76a3CB8974823F43Cb9AAA"
    bridgeContract = "0xf763c9ec62a9ff998da4c205c0f78b7024c66b68" # OriginalTokenVault
    wbnbContract = "0x2cB322C585D7640b9C41D9b4b58De4C3d60f2d6D"
    tokenContract = MockUniETH.at("0xa0c8D36EBDA8bC2F3466836D8bEa87a736b8c467")

    # deploy mock staking with token contract and approve to staking contract
    stakingContract = MockStaking.deploy(tokenContract, {'from':deployer}, publish_source=True)
    tokenContract.setMintable(stakingContract, True, {'from': deployer})

    # deployer receiver
    receiver = CelerMinterReceiver.deploy(
            messageBus,
            bridgeContract,
            wbnbContract,
            stakingContract,
            {'from': deployer},publish_source=True)
