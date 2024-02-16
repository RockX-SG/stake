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

    xETH_contract = RockXETH.deploy(
            {'from': deployer}
            )

    xETH_proxy = TransparentUpgradeableProxy.deploy(
            xETH_contract, deployer, b'',
            {'from': deployer}
            )

    staking_contract = RockXStaking.deploy(
            {'from': deployer}
            )

    staking_proxy = TransparentUpgradeableProxy.deploy(
            staking_contract, deployer, b'',
            {'from': deployer}
            )

    redeem_contract = RockXRedeem.deploy(
            {'from': deployer}
            )

    redeem_proxy = TransparentUpgradeableProxy.deploy(
            redeem_contract, deployer, b'',
            {'from': deployer}
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
    transparent_xeth.setMintable(
            staking_proxy, True,
            {'from': owner}
            )

    transparent_redeem.initialize(
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
    #withdrawalCredential = ETH1_ADDRESS_WITHDRAWAL_PREFIX
    #withdrawalCredential += b'\x00' * 11
    #withdrawalCredential += bytes.fromhex(transparent_staking.address[2:])
    #print("withdrawCredential:", withdrawalCredential.hex())

    #transparent_staking.setWithdrawCredential(
    #        withdrawalCredential,
    #        {'from': owner, 'gas': GAS_LIMIT}
    #        )

    transparent_staking.registerValidator(
            0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db, 
            0xa09b4dc28c10063f6e2a9d2ca94b23db029ef618660138898cb827eae227d99ee1c438988d0222ca4229ba85c40add3b045e823fdb7519a36538ff901ab89f311060bcecc517ba683b84009ee3509afbcd25e991ef34112a5a16be44265441eb,
            {'from': owner}
            )

    
    transparent_staking.setManagerFeeShare(100, {'from':owner})
    transparent_staking.switchPhase(1, {'from':owner})
    print("quota used",transparent_staking.getQuota(owner))
    mintTX = transparent_staking.mint('32 ether', time.time() + 600, {'from':owner, 'value': '32 ether'})
    print("mintTX", mintTX)
    transparent_xeth.approve(transparent_staking, '10000 ethers', {'from': owner})

    print("===== mint redeem test========")
    vectorClock = transparent_staking.getVectorClock()
    print("vector clock:", vectorClock)
    print("accounted balance:", transparent_staking.getAccountedBalance())
    print("balance:", transparent_staking.balance())
    transparent_staking.syncBalance({'from':owner})
    vectorClock = transparent_staking.getVectorClock()
    print("vector clock:", vectorClock)
    transparent_staking.stake({'from':owner})
    print("currentReserve:", transparent_staking.currentReserve())
    print("pushBeacon 32.1 ethers")
    transparent_staking.pushBeacon(1, transparent_staking.getVectorClock(), {'from':owner})
    print("redeem 32 ether")
    transparent_staking.redeemFromValidators('32 ethers', '33 ethers', time.time() + 600, {'from':owner})
    accounts[0].transfer(transparent_staking.address, '32.1 ethers')
    vectorClock = transparent_staking.getVectorClock()
    print("vector clock:", vectorClock)
    print("validator stopped exchangeRatio before:", transparent_staking.exchangeRatio())
    transparent_staking.validatorStopped([0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db], vectorClock, {'from':accounts[0]})
    print("pushBeacon 0 ethers")
    transparent_staking.pushBeacon(0, transparent_staking.getVectorClock() , {'from':owner})
    print("validator stopped exchangeRatio after:", transparent_staking.exchangeRatio())

    print("===== whitelist test ========")
    print(owner, "check whitelist of:", transparent_staking.isWhiteListed(owner))
    print(owner, "quota used",transparent_staking.getQuota(owner))
    print(owner, "add to whitelist")
    transparent_staking.toggleWhiteList(owner, {'from':owner})
    print(owner, "check whitelist", transparent_staking.isWhiteListed(owner))
    print(owner, "quota used",transparent_staking.getQuota(owner))
    print(owner, "mint 32 ethers")
    tx = transparent_staking.mint(0, time.time() + 600, {'from':owner, 'value': '32 ether'})
    print(owner, "quota used",transparent_staking.getQuota(owner))

    print("===== manager withdrawal test========")
    print("syncBalance")
    transparent_staking.syncBalance({'from':owner})
    print("manager fee before claiming:",transparent_staking.getAccountedManagerRevenue(), " exchange ratio:", transparent_staking.exchangeRatio())
    print("pending ethers before", transparent_staking.getPendingEthers()) 
    print("claim to another account:", accounts[2])
    transparent_staking.withdrawManagerFee(transparent_staking.getAccountedManagerRevenue(), accounts[2], {'from':owner})
    print("uniETH token balance on", accounts[2], "is:",  transparent_xeth.balanceOf(accounts[2]))
    print("manager fee after claiming:",transparent_staking.getAccountedManagerRevenue(), " exchange ratio:", transparent_staking.exchangeRatio())
    print("pending ethers after", transparent_staking.getPendingEthers()) 



    
