from brownie import *
from pathlib import Path

def main():
    deployer = accounts.load('mainnet-deployer')
    rate_proxy = BalancerRateProxy.deploy(
            "0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d",
            {'from': deployer}, publish_source=True
            )


    print("getRate", rate_proxy.getRate())
 
