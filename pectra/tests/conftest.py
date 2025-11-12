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
def pubkeys():
    return [0x99b775b52eec36ffe05e4826194f9f623534f2e2d6a4fae9db9eccc38de09eb311fc13822bd2936342e2e86f27d96b0b, 
            0x868a96dc62b8918eb364842b1a75b0f277e84e558fc091c1dfeff905f7f7d94214326d3559a4051c2818757d69b42127,
            0xa11eae5ca1ee231c927714bd7565c1dc101546a7ec27de73102380d5290a39632e10a39f173accc9963853c1ab2eb89b,
            0xb2af959e38f60a258238ea8fe60490a60991826dafe2ceaa92d313550e97e78b54836f276b5bb4b477562f4c5b6ae570,
            0xb2cdb534b47627ecf49f94cad6258adf04f69d886d741c7878e01b18c6b018b2f8e0a4c81da2a2138a8fb6eb59bf9ac5]

@pytest.fixture
def sigs():
    return [0x938f19413f81f032099eff3aaeef41a1bec91ed0b64e53b6dd4568735ae05d26249f83b4584f82dc05773dd5eef0e6ca0bc9f9b0df17cde5ef51cb1d9bbce1ecaf7fff98eb65a74998973ae610be733dbf5448e1605e71779c9779a8ca3e487a,
            0xb240dc25ba922e4fbe88785fd4afb2592d71dbe042700a416367725ae8902968c2269999906feebafa0787983cef993a062f975c48465f8f1b4cc12bc606cde5b701efef0b3ec67e64b25c39bf6fa6a3e1e7961d904eb6316164a48c79b78c45,
            0xa4f9ffc0195dfff84a6469666ebb9661ca14a8d103afa758991bb9de58e71382b1d4d70c220c1458509cdcbcd580f6300cb70078ff194bbb540d4784b23206871ecb2f6c63f5eceae9d6c22de6d14e6df1787820963c796deb89c212c837944e,
            0x979b2452c2a784cc55fab298428ccea0cad2c267db45cab2a92b9b07bd9f0648c63eef60e48872c53b11b8800559adb90a01e15ac2e345bdf576afaa16b33b3ef4c5d28aea3ba86170d02eb5d26f2717fc75a566a041c215e1131991a2d8c67f,
            0x8e3879d53b77713dcbe2618fba82fddbbc348da60a34df6baf1d759e530ab9507cdf8022d01aa8fcea958b68861346a70774ef8945546c84b21fbbf171dc8101a7422e1c8ca38ccdfeb41cdfca0f3612f78c165cae7ebe267de72137593162c7]

@pytest.fixture
def oldpubkeys():
    return [0x99b775b52eec36ffe05e4826194f9f623534f2e2d6a4fae9db9eccc38de09eb311fc13822bd2936342e2e86f27d96b0b,
            0x868a96dc62b8918eb364842b1a75b0f277e84e558fc091c1dfeff905f7f7d94214326d3559a4051c2818757d69b42127]

@pytest.fixture
def oldsigs():
    return [0x938f19413f81f032099eff3aaeef41a1bec91ed0b64e53b6dd4568735ae05d26249f83b4584f82dc05773dd5eef0e6ca0bc9f9b0df17cde5ef51cb1d9bbce1ecaf7fff98eb65a74998973ae610be733dbf5448e1605e71779c9779a8ca3e487a,
            0xb240dc25ba922e4fbe88785fd4afb2592d71dbe042700a416367725ae8902968c2269999906feebafa0787983cef993a062f975c48465f8f1b4cc12bc606cde5b701efef0b3ec67e64b25c39bf6fa6a3e1e7961d904eb6316164a48c79b78c45]
@pytest.fixture
def replacepubkeys():
    return [0xa11eae5ca1ee231c927714bd7565c1dc101546a7ec27de73102380d5290a39632e10a39f173accc9963853c1ab2eb89b,
            0xb2af959e38f60a258238ea8fe60490a60991826dafe2ceaa92d313550e97e78b54836f276b5bb4b477562f4c5b6ae570]

@pytest.fixture
def replacesigs():
    return [0xa4f9ffc0195dfff84a6469666ebb9661ca14a8d103afa758991bb9de58e71382b1d4d70c220c1458509cdcbcd580f6300cb70078ff194bbb540d4784b23206871ecb2f6c63f5eceae9d6c22de6d14e6df1787820963c796deb89c212c837944e,
            0x979b2452c2a784cc55fab298428ccea0cad2c267db45cab2a92b9b07bd9f0648c63eef60e48872c53b11b8800559adb90a01e15ac2e345bdf576afaa16b33b3ef4c5d28aea3ba86170d02eb5d26f2717fc75a566a041c215e1131991a2d8c67f]

@pytest.fixture
def restake():
    return True

@pytest.fixture
def setup_contracts(owner, deployer):
    chain.reset()
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
