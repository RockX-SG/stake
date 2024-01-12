import pytest
import time
import sys

from pathlib import Path
from brownie import *

deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])

@pytest.fixture
def sender():
    user = accounts.load('goerli-deployer')
    return user

@pytest.fixture
def destinationChain():
    return "arbitrum"

@pytest.fixture
def destinationContract():
    return 0xBe69AB292f3F5A6DE0611Ed1FB13b2dDAf2dE0B2

@pytest.fixture
def ratioSenderContract():
    ratio_sender = Contract.from_abi("ExchangeRatioSender", "0x66cAE11268eb784F51b4468814f601317d6249Bb", ExchangeRatioSender.abi)
    return ratio_sender

@pytest.fixture
def ratioReceiverContract():
    ratio_receiver = Contract.from_abi("ExchangeRatioReceiver", "0xBe69AB292f3F5A6DE0611Ed1FB13b2dDAf2dE0B2", ExchangeRatioReceiver.abi)
    return ratio_receiver
