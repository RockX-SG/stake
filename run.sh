#!/bin/bash

brownie networks add development mainnet-fork2 cmd=ganache-cli host=http://0.0.0.0 accounts=10 mnemonic=brownie port=8545 fork=mainnet
brownie run ./scripts/test_deploy.py --network mainnet-fork2  -I
