import pytest
import time

from brownie import *
from pathlib import Path

GAS_LIMIT = 6721975
deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])

@pytest.fixture
def setup():
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy

    owner = accounts[0]
    deployer = accounts[1]
    ethDepositContract = "0x00000000219ab540356cbb839cbe05303d7705fa"
    withdrawalCredential = "0x00a7ea5e6d29ffaf8e80a35f419dd1603c5575f9d68ed75392a356ca17084c90"

    print(f'contract owner account: {owner.address}\n')

    xETH_contract = RockXETH.deploy(
        {'from': deployer, 'gas': GAS_LIMIT}
    )

    xETH_proxy = TransparentUpgradeableProxy.deploy(
        xETH_contract, deployer, b'',
        {'from': deployer, 'gas': GAS_LIMIT}
    )

    staking_contract = RockXStaking.deploy(
        {'from': deployer, 'gas': GAS_LIMIT}
    )

    staking_proxy = TransparentUpgradeableProxy.deploy(
        staking_contract, deployer, b'',
        {'from': deployer, 'gas': GAS_LIMIT}
    )

    global transparent_xeth
    global transparent_staking
    transparent_xeth = Contract.from_abi("RockXETH", xETH_contract.address, RockXETH.abi)
    transparent_staking = Contract.from_abi("RockXStaking",staking_proxy.address, RockXStaking.abi)

    transparent_xeth.initialize(
        {'from': owner, 'gas': GAS_LIMIT}
    )
    transparent_xeth.setMintable(
        staking_proxy, True,
        {'from': owner, 'gas': GAS_LIMIT}
    )

    transparent_staking.initialize(
        {'from': owner, 'gas': GAS_LIMIT}
    ) 

    transparent_staking.setXETHContractAddress(
        transparent_xeth,
        {'from': owner, 'gas': GAS_LIMIT}
    )

    transparent_staking.setETHDepositContract(
        ethDepositContract,
        {'from': owner, 'gas': GAS_LIMIT}
    ) 

    transparent_staking.setWithdrawCredential(
        withdrawalCredential,
        {'from': owner, 'gas': GAS_LIMIT}
    )

    transparent_staking.switchPhase(1,{'from':owner})
    transparent_staking.registerValidator(
            0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db, 
            0xa09b4dc28c10063f6e2a9d2ca94b23db029ef618660138898cb827eae227d99ee1c438988d0222ca4229ba85c40add3b045e823fdb7519a36538ff901ab89f311060bcecc517ba683b84009ee3509afbcd25e991ef34112a5a16be44265441eb,
        {'from': owner, 'gas': GAS_LIMIT}
    )

def test_mint(setup):
    user1 = accounts[2]
    user1.transfer(to=transparent_staking, amount='1 ether')
    transparent_xeth.approve(transparent_staking, '100 ether', {'from': user1})
    transparent_staking.mint(0, {'from':user1, 'value': "1 ether"})
    assert transparent_staking.exchangeRatio() == 1e18

def test_redeem(setup):
    user1 = accounts[2]
    user2 = accounts[3]
    transparent_staking.mint(0, {'from':user1, 'value': "32 ether"})
    assert transparent_xeth.balanceOf(user1) == '32 ether'
    
    transparent_xeth.approve(transparent_staking, '100 ether', {'from': user1})
    transparent_staking.redeemFromValidators("32 ether", "32 ether", {'from': user1})
    assert transparent_staking.debtOf(user1) == '32 ether'
    assert transparent_staking.exchangeRatio() == 1e18
    assert transparent_xeth.balanceOf(user1) == 0

    transparent_staking.mint(0, {'from':user2, 'value': "8 ether"})
    assert transparent_staking.debtOf(user1) == '24 ether'

def test_beacon(setup):
    expectedExchangeRatio = 1009000000000000000
    # some ethers to redeem
    user1 = accounts[2]
    user1.transfer(to=transparent_staking, amount='50 ether')

    oracle = accounts[3]
    transparent_staking.mint(0, {'from':oracle, 'value': "32 ether"})
    assert transparent_xeth.balanceOf(oracle) == '32 ether'

    transparent_staking.grantRole(transparent_staking.ORACLE_ROLE(), oracle, {'from': accounts[0]})
    transparent_staking.pushBeacon(1, '32.32 ether', int(time.time()), {'from':oracle})

    assert transparent_staking.exchangeRatio() == expectedExchangeRatio

