from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    TimelockController = deps.TimelockController

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

    transparent_token = Contract.from_abi("BedrockDAO", token_proxy.address, BedrockDAO.abi)
    transparent_token.initialize( {'from': owner})

    transparent_govern = Contract.from_abi("BedrockGovernor", govern_proxy.address, BedrockGovernor.abi)
    transparent_govern.initialize(transparent_token, {'from': owner})

    print("token address:", transparent_token)
    print("govern address:", transparent_govern)
