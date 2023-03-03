from brownie import *
from pathlib import Path

import time
import pytest

def main():
    deps = project.load(  Path.home() / ".brownie" / "packages" / config["dependencies"][0])
    ProxyAdmin = deps.ProxyAdmin

    owner = accounts.load('mainnet-owner')
    proxyAdmin = ProxyAdmin.deploy({'from': owner}, publish_source=True)



