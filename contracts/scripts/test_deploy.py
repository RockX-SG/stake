from brownie import (
        RockXETH,
        RockXStaking,
        accounts,
        chain,
        interface
)

GAS_LIMIT = 6721975

def main():
    owner = accounts[0]
    admin = owner
    ethDepositContract = "0x00000000219ab540356cbb839cbe05303d7705fa"
    withdrawalCredential = "0x00a7ea5e6d29ffaf8e80a35f419dd1603c5575f9d68ed75392a356ca17084c90"

    print(f'contract owner account: {owner.address}\n')

    xETH_contract = RockXETH.deploy(
        {'from': admin, 'gas': GAS_LIMIT}
    )

    staking_contract = RockXStaking.deploy(
        {'from': admin, 'gas': GAS_LIMIT}
    )
   
    xETH_contract.initialize()
    xETH_contract.setMintable(staking_contract, True)
    staking_contract.initialize()
    staking_contract.setXETHContractAddress(xETH_contract)
    staking_contract.setETHDepositContract(ethDepositContract)
    staking_contract.setWithdrawCredential(withdrawalCredential)
    staking_contract.registerValidator(
            0x97d717d346868b9df4851684d5219f4deb4c7388ee1454c9b46837d29b40150ceeb5825d791f993b03745427b6cbe6db, 
            0xa09b4dc28c10063f6e2a9d2ca94b23db029ef618660138898cb827eae227d99ee1c438988d0222ca4229ba85c40add3b045e823fdb7519a36538ff901ab89f311060bcecc517ba683b84009ee3509afbcd25e991ef34112a5a16be44265441eb)

    

