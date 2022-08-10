from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deployer = accounts.load('goerli-deployer')

    staking_contract = RockXStaking.deploy(
            {'from': deployer},publish_source=True
            )
