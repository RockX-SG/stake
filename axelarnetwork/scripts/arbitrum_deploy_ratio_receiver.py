from brownie import *
from pathlib import Path

import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    deployer = accounts.load('arbitrum-deployer')

    print(f'contract owner account: {deployer.address}\n')

    gmpArbitrumGateway = "0xe432150cce91c13a887f7D836923d5597adD8E31"
    ratio_receiver_contract = ExchangeRatioReceiver.deploy( gmpArbitrumGateway,
            {'from': deployer}, 
            )

    print("gmpExchangeRatioReceiver address:", ratio_receiver_contract)
