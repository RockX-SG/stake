from brownie import *
from pathlib import Path

import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    deployer = accounts.load('eth-mainnet-deployer')

    print(f'contract owner account: {deployer.address}\n')

    ethMainnetGateway = "0x4F4495243837681061C4743b74B3eEdf548D56A5"
    ethMainnetGasService = "0x2d5d7d31F671F86C782533cc367F14109a082712"
    ethUniethContract = "0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d"
    ratio_sender_contract = ExchangeRatioSender.deploy( ethMainnetGateway,ethMainnetGasService,ethUniethContract,
            {'from': deployer}, publish_source=True
            )

    print("gmpExchangeRatioSender address:", ratio_sender_contract)
