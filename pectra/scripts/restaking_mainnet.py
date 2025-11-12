from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    owner = accounts[0]
    deployer = accounts[1]

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
    
    # restaking address 
    pubkeys = [0x9739c7d31f92e4f23d8d9fad9396154255cc4644533e5cde6a1ab4f7ad37da15e748a1317f721658302f1cd1f2b234e5]
    sigs = [0xb94da5641c955a3f4620329387010057ab4b5d7344b823a59607d960e8eeeebfe0f8164fac976c4ed97261b991c157d508ec31edc65f93ee1adfda16a25d20c457b247092fab287b3619b66f35277767cfa5a3e83d4499d7fceb690a5007be2d]
    transparent_staking.registerRestakingValidators(pubkeys, sigs, {'from': owner})

    assert transparent_staking.getRegisteredValidatorsCount() == len(pubkeys)
    results = transparent_staking.getRegisteredValidators(0, len(pubkeys))

    # setup restaking deployment
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    restaking_contract = RockXRestaking.deploy( {'from': owner})
    restaking_proxy = TransparentUpgradeableProxy.deploy(
            restaking_contract.address, deployer, b'',
            {'from': deployer})

    #init 
    eigenpod_manager = '0x91E677b07F7AF907ec9a428aafA9fc14a0d3A338'
    delegation_manager = '0x39053D51B77DC0d36036Fc1fCc8Cb819df8Ef37A'
    strategy_manager = '0x858646372CC42E1A627fcE94aa7A7033e7CF075A'
    delayed_withdrawal_router = '0x7Fe7E9CC0F274d2435AD5d56D5fa73E47F6A23D8'

    transparent_restaking = Contract.from_abi("RockXRestaking",restaking_proxy, RockXRestaking.abi)
    transparent_restaking.initialize(eigenpod_manager, delegation_manager, strategy_manager, delayed_withdrawal_router, {'from': owner})

    # set eigenpod to staking contract
    transparent_staking.setRestakingAddress(transparent_restaking.eigenPod(), {'from':owner})
    print("restaking address", transparent_staking.restakingAddress(), transparent_staking.restakingWithdrawalCredentials()) 

    # mint
    assert transparent_staking.getNextValidatorId() == 0
    transparent_staking.toggleWhiteList(owner, {'from':owner})
    assert transparent_staking.isWhiteListed(owner) == True
    transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '64 ether'})
