from brownie import *
from brownie.convert import EthAddress
from brownie.network import priority_fee
from pathlib import Path

import time
import pytest

def main():
    priority_fee("80 gwei")
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts.load('goerli-owner')
    deployer = accounts.load('goerli-deployer')

    print(f'contract owner account: {owner.address}\n')

    token_contract = BedrockDAO.deploy(
            {'from': deployer}, publish_source=True)

    token_proxy =  TransparentUpgradeableProxy.deploy(
            token_contract, deployer, b'',
            {'from': deployer}, publish_source=True)

    govern_contract = BedrockGovernor.deploy(
            {'from': deployer}, publish_source=True)

    govern_proxy = TransparentUpgradeableProxy.deploy(
            govern_contract, deployer, b'',
            {'from': deployer}, publish_source=True)

    timelock = TimeLock.deploy(
            86400*1,
            [govern_proxy.address],
            ["0x0000000000000000000000000000000000000000"],
            owner,
            {'from': deployer}, publish_source=True)

    transparent_token = Contract.from_abi("BedrockDAO", token_proxy.address, BedrockDAO.abi)
    transparent_govern = Contract.from_abi("BedrockGovernor", govern_proxy.address, BedrockGovernor.abi)

    print("TOKEN ADDRESS:", transparent_token)
    print("GOVERN ADDRESS:", transparent_govern)
    print("TIMELOCK ADDRESS:", timelock)

    transparent_token.initialize( {'from': owner})
    transparent_govern.initialize(transparent_token, timelock, {'from': owner})

