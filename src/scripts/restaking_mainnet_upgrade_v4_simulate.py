from brownie import *
from pathlib import Path

import time
import pytest


def main():
    deps = project.load(
        Path.home() / ".brownie" / "packages" / config["dependencies"][0]
    )
    TransparentUpgradeableProxy = deps.TransparentUpgradeableProxy
    ProxyAdmin = deps.ProxyAdmin
    proxy_admin_contract = ProxyAdmin.at("0xa5F2B6AB5B38b88Ba221741b3A189999b4c889C6")
    eigen_token_address = "0xec53bF9167f50cDEB3Ae105f56099aaaB9061F83"
    restaking_proxy_address = "0x3F4eaCeb930b0Edfa78a1DFCbaE5c5494E6e9850"
    restaking_proxy = TransparentUpgradeableProxy.at(restaking_proxy_address)
    eigen_rewarded_proxy = "0x7750d328b314EfFa365A0402CcfD489B80B0adda"
    gnosis_safe = accounts.at(
        "0xAeE017052DF6Ac002647229D58B786E380B9721A", {"force": True}
    )
    operator = accounts.at(
        "0xB2a8e6E0d0Bb81299897B918284A9Fca68E3f081", {"force": True}
    )
    deployer = accounts[0]
    erc20_eigen = Contract.from_abi(
        "ERC20",
        eigen_token_address,
        [
            # ERC-20 的部分标准 ABI
            {
                "constant": True,
                "inputs": [{"name": "_owner", "type": "address"}],
                "name": "balanceOf",
                "outputs": [{"name": "balance", "type": "uint256"}],
                "type": "function",
            }
        ],
    )

    # simulate restaking contract upgrade
    restaking_contract = Restaking.deploy({"from": deployer})
    calldata = Restaking[-1].initializeV4.encode_input(eigen_rewarded_proxy)
    proxy_admin_contract.upgradeAndCall(
        restaking_proxy, restaking_contract, calldata, {"from": gnosis_safe}
    )

    eigen_balance = erc20_eigen.balanceOf(restaking_proxy_address)
    print("eigen_balance amount", eigen_balance)
    transparent_restaking = Contract.from_abi(
        "Restaking", restaking_proxy, Restaking.abi
    )
    """
    claim_data = {
        "rootIndex": 21,
        "earnerIndex": 38789,
        "earnerTreeProof": [
            bytes.fromhex("fd4e957ecb3b34eed7ff241c2102dc85d82f38e6931eab213fa3d27bfe95945966de87d07dacf9e99f75c3359e54fd5c5f230714e1e27fdbf83b04c6048e8506cbb85c46a6e4413708542e257415179ee4bb58ef7e6f3786d6d2a146bef87ecc03d8c4677c20f1bd51480f8ac21fe83e6c9114f921a29d7dee10997bb618007e0953673628dbd0318bcf64ff89e765e14d7ca6dc7849087f8c821db18994478b1a6bc78b6522288defb6c34348bce8029118b93748eb9c4628abf8c9f03befb4eb388044ccad56ee78318b44209f3f81ccd4cabd4d24ce97e3d00cf57a498ed1895a73d4936d60db67bf8f7456d1f9368cb222a67e06759b376612208114dc394ebf4656814d255061e7c66f362e9a539431637cabe27239906592f8bae15dae53e1cfcaf45ffacb5a02a5971a4dbe894945eceb66a546ba6cee7fa008ae71f631df1a993791e4146296d72d5614a27901ba0bd8690f651e1bfd9878dfa3a8964be61db8346573e6af2a6c86a9dc2b5fb1240b4f225cd4ffa02cfda17076d7b5886558f9b8caf5222aa1036c38fb6dbb89443197e0e9c3b9e078b6d2c41837ade6cab80796468c0ce3f569b37319995462f24cb6c116107b2d70b5ee984a16151d707a0ff8c2af96406b8aa61909ca398d92e3798fc3ab7cd5baf6baf55d450a7444106b46239cb965cfaa7236c0f2ec8e5ea5656cee666ef010f27952d79133d82d102279a9ed60140c85a995ef7e7de0b492cd66e4caf6179366c2720b9c68de1a541ede97802594cd7ae2a7a433ae94b901c34097fc41b364e58146c0faf1"),
        ],
        "earnerLeaf": {
            "earner": "0x3f4eaceb930b0edfa78a1dfcbae5c5494e6e9850",
            "earnerTokenRoot": bytes.fromhex("00eb6975209027b214b072ab0530b93e2e4862699f13e14f894866a823c7ca21"),
        },
        "tokenIndices": [0, 1],
        "tokenTreeProofs": [
            bytes.fromhex("b2410f3c21b9e234365c9664cc2463407134c3cb6a76ef75c99b8629a572f8dd"),
            bytes.fromhex("8129fc4f1b38cc97d14981cd4ebb3d261f4290b8c42af00ac2c7e69228a8db26"),
        ],
        "tokenLeaves": [
            {
                "token": "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
                "cumulativeEarnings": "65955484345064147",
            },
            {
                "token": "0xec53bf9167f50cdeb3ae105f56099aaab9061f83",
                "cumulativeEarnings": "50364936135183671571768",
            },
        ],
    } 
    """
    claim_data = (
        21,
        38789,
        bytes.fromhex(
            "fd4e957ecb3b34eed7ff241c2102dc85d82f38e6931eab213fa3d27bfe95945966de87d07dacf9e99f75c3359e54fd5c5f230714e1e27fdbf83b04c6048e8506cbb85c46a6e4413708542e257415179ee4bb58ef7e6f3786d6d2a146bef87ecc03d8c4677c20f1bd51480f8ac21fe83e6c9114f921a29d7dee10997bb618007e0953673628dbd0318bcf64ff89e765e14d7ca6dc7849087f8c821db18994478b1a6bc78b6522288defb6c34348bce8029118b93748eb9c4628abf8c9f03befb4eb388044ccad56ee78318b44209f3f81ccd4cabd4d24ce97e3d00cf57a498ed1895a73d4936d60db67bf8f7456d1f9368cb222a67e06759b376612208114dc394ebf4656814d255061e7c66f362e9a539431637cabe27239906592f8bae15dae53e1cfcaf45ffacb5a02a5971a4dbe894945eceb66a546ba6cee7fa008ae71f631df1a993791e4146296d72d5614a27901ba0bd8690f651e1bfd9878dfa3a8964be61db8346573e6af2a6c86a9dc2b5fb1240b4f225cd4ffa02cfda17076d7b5886558f9b8caf5222aa1036c38fb6dbb89443197e0e9c3b9e078b6d2c41837ade6cab80796468c0ce3f569b37319995462f24cb6c116107b2d70b5ee984a16151d707a0ff8c2af96406b8aa61909ca398d92e3798fc3ab7cd5baf6baf55d450a7444106b46239cb965cfaa7236c0f2ec8e5ea5656cee666ef010f27952d79133d82d102279a9ed60140c85a995ef7e7de0b492cd66e4caf6179366c2720b9c68de1a541ede97802594cd7ae2a7a433ae94b901c34097fc41b364e58146c0faf1"
        ),
        (
            "0x3f4eaceb930b0edfa78a1dfcbae5c5494e6e9850",
            bytes.fromhex(
                "00eb6975209027b214b072ab0530b93e2e4862699f13e14f894866a823c7ca21"
            ),
        ),
        [0, 1],
        [
            bytes.fromhex(
                "b2410f3c21b9e234365c9664cc2463407134c3cb6a76ef75c99b8629a572f8dd"
            ),
            bytes.fromhex(
                "8129fc4f1b38cc97d14981cd4ebb3d261f4290b8c42af00ac2c7e69228a8db26"
            ),
        ],
        [
            (
                "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
                65955484345064147,
            ),
            (
                "0xec53bf9167f50cdeb3ae105f56099aaab9061f83",
                50364936135183671571768,
            ),
        ],
    )

    transparent_restaking.processClaim(claim_data, 0, {"from": operator})
    eigen_balance = erc20_eigen.balanceOf(restaking_proxy_address)
    print("eigen_balance after claimed amount", eigen_balance)

    tx = transparent_restaking.withdrawReward(
        eigen_token_address, accounts[0], eigen_balance, {"from": gnosis_safe}
    )
    
    eigen_balance = erc20_eigen.balanceOf(restaking_proxy_address)
    print("eigen_balance after withdraw amount", eigen_balance)
