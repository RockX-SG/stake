from brownie import *
from brownie.convert import EthAddress
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts[0]
    deployer = accounts[1]

    print(f'contract owner account: {owner.address}\n')

    token_contract = BedrockDAO.deploy(
            {'from': deployer})

    token_proxy =  TransparentUpgradeableProxy.deploy(
            token_contract, deployer, b'',
            {'from': deployer})

    govern_contract = BedrockGovernor.deploy(
            {'from': deployer})

    govern_proxy = TransparentUpgradeableProxy.deploy(
            govern_contract, deployer, b'',
            {'from': deployer})

    timelock = TimeLock.deploy(
            86400*1,
            [govern_proxy.address],
            ["0x0000000000000000000000000000000000000000"],
            owner,
            {'from': owner})


    transparent_token = Contract.from_abi("BedrockDAO", token_proxy.address, BedrockDAO.abi)
    transparent_token.initialize( {'from': owner})

    transparent_govern = Contract.from_abi("BedrockGovernor", govern_proxy.address, BedrockGovernor.abi)
    transparent_govern.initialize(transparent_token, timelock, {'from': owner})

    print("TOKEN ADDRESS:", transparent_token)
    print("GOVERN ADDRESS:", transparent_govern)
    print("TIMELOCK ADDRESS:", timelock)
