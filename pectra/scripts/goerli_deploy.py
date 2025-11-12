from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts.load('goerli-owner')
    deployer = accounts.load('goerli-deployer')

    if chain.id == 1:
        ethDepositContract = "0x00000000219ab540356cbb839cbe05303d7705fa"
    elif chain.id == 5:
        ethDepositContract = "0xff50ed3d0ec03aC01D4C79aAd74928BFF48a7b2b"
    else:
        assert False 

    print(f'contract owner account: {owner.address}\n')

    redeem_contract = RockXRedeem.deploy(
            {'from': deployer}, publish_source=True
            )

    redeem_proxy = TransparentUpgradeableProxy.deploy(
            redeem_contract, deployer, b'',
            {'from': deployer}, publish_source=True
            )


    xETH_contract = RockXETH.deploy(
            {'from': deployer} ,publish_source=True
            )

    xETH_proxy = TransparentUpgradeableProxy.deploy(
            xETH_contract, deployer, b'',
            {'from': deployer},publish_source=True
            )

    staking_contract = RockXStaking.deploy(
            {'from': deployer},publish_source=True
            )

    staking_proxy = TransparentUpgradeableProxy.deploy(
            staking_contract, deployer, b'',
            {'from': deployer},publish_source=True
            )


    transparent_xeth = Contract.from_abi("RockXETH", xETH_proxy.address, RockXETH.abi)
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy.address, RockXStaking.abi)
    transparent_redeem  = Contract.from_abi("RockXRedeem", redeem_proxy.address, RockXRedeem.abi)

    print("xETH address:", transparent_xeth)
    print("RockXStaking address:", transparent_staking)
    print("Redeem address:", transparent_redeem)

    transparent_xeth.initialize(
            {'from': owner}
            )
    transparent_redeem.initialize(
            {'from': owner}
            )
    transparent_xeth.setMintable(
            staking_proxy, True,
            {'from': owner}
            )

    transparent_staking.initialize(
            {'from': owner}
            ) 

    transparent_staking.setXETHContractAddress(
            transparent_xeth,
            {'from': owner}
            )

    transparent_staking.setETHDepositContract(
            ethDepositContract,
            {'from': owner}
            ) 

    transparent_staking.setRedeemContract(
            transparent_redeem,
            {'from': owner}
            ) 

    print("default withdrawl credential:",  transparent_staking.withdrawalCredentials())
