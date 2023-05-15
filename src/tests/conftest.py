import pytest
import time
import sys

from pathlib import Path
from brownie import convert
from brownie import *

deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])

@pytest.fixture
def owner():
    return accounts[0]

@pytest.fixture
def deployer():
    return accounts[1]

@pytest.fixture
def setup_contracts(owner, deployer):
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    if chain.id == 1:
        ethDepositContract = "0x00000000219ab540356cbb839cbe05303d7705fa"
    elif chain.id == 5:
        ethDepositContract = "0xff50ed3d0ec03aC01D4C79aAd74928BFF48a7b2b"
    else:  
        assert False

    print(f'contract owner account: {owner.address}\n')

    xETH_contract = RockXETH.deploy({'from': deployer})
    xETH_proxy = TransparentUpgradeableProxy.deploy(xETH_contract, deployer, b'', {'from': deployer})

    staking_contract = RockXStaking.deploy({'from': deployer})
    staking_proxy = TransparentUpgradeableProxy.deploy(staking_contract, deployer, b'', {'from': deployer})

    redeem_contract = RockXRedeem.deploy({'from': deployer})
    redeem_proxy = TransparentUpgradeableProxy.deploy(redeem_contract, deployer, b'', {'from': deployer})

    transparent_xeth = Contract.from_abi("RockXETH", xETH_proxy.address, RockXETH.abi)
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy.address, RockXStaking.abi)
    transparent_redeem = Contract.from_abi("RockXRedeem", redeem_proxy.address, RockXRedeem.abi)

    transparent_xeth.initialize({'from': owner})
    transparent_xeth.setMintable(staking_proxy, True, {'from': owner})

    transparent_staking.initialize({'from': owner})
    transparent_staking.setXETHContractAddress(transparent_xeth, {'from': owner})
    transparent_staking.setETHDepositContract(ethDepositContract, {'from': owner})

    transparent_staking.setRedeemContract(transparent_redeem, {'from': owner}) 
    transparent_staking.switchPhase(1,{'from':owner})
    
    return transparent_xeth, transparent_staking, transparent_redeem

