# Stake

## Usage

### 1. Create an API KEY from [access.rockx.com](https://access.rockx.com)

### 2. Install brownie from [brownie](https://eth-brownie.readthedocs.io/en/stable/quickstart.html)

### 3. Follow: [brownie-integration](https://rockx.gitbook.io/rockx-access-node-manual/brownie-integration) to setup brownie network
```
$brownie networks modify mainnet host=https://eth.w3node.com/\$ROCKX_API_KEY/api provider=rockx

Brownie v1.18.1 - Python development framework for Ethereum

SUCCESS: Network 'Mainnet' has been modified
  └─Mainnet
    ├─id: mainnet
    ├─chainid: 1
    ├─explorer: https://api.etherscan.io/api
    ├─host: https://eth.w3node.com/$ROCKX_API_KEY/api
    ├─multicall2: 0x5BA1e12693Dc8F9c48aAD8770482f4739bEeD696

$ export ROCKX_API_KEY=<YOUR API KEY>
```

### 4. Deploy to mainnet-fork
```
$brownie run scripts/ganache_deploy.py --network mainnet-fork -I
```
