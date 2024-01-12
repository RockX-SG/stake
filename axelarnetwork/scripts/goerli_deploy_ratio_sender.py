from brownie import *
from pathlib import Path

import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    deployer = accounts.load('goerli-deployer')

    print(f'contract owner account: {deployer.address}\n')

    gmpGoerliGateway = "0xe432150cce91c13a887f7D836923d5597adD8E31"
    gmpGoerliGasService = "0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6"
    goerliUniethContract = "0xa6E1a466626Db4927C197468026fa0A54c092492"
    ratio_sender_contract = ExchangeRatioSender.deploy( gmpGoerliGateway,gmpGoerliGasService,goerliUniethContract,
            {'from': deployer}, publish_source=True
            )

    print("gmpExchangeRatioSender address:", ratio_sender_contract)
