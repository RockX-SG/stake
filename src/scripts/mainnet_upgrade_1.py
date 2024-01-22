from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deployer = accounts.load('mainnet-deployer')

    staking_contract = RockXStaking.deploy( {'from': deployer})
