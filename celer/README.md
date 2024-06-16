## celer cbridge integration deploy

### roles

- sender: dApp contract for user swap eth/wETH to uniETH
- cBridge: all the cbridge info can find here: https://cbridge-docs.celer.network/reference/contract-addresses#peggedtokenbridge-v2-contract
- executor: exec some retry/timer logic
- receiver: receive weth on eth mainnet and mint uniETH

### address:

- receiver(by rockx):
  - address: 0x7C3F1fe22959b4f6aC2Bf2474B3bDf9969465C95 , chain: Ethereum

- executor:
  - address: 0xa9f4e8e837e7f8ab56bc4c627971a3864fdeca44 , chain: "EOA on all chain"
- origin token vault (uniETH):
  - address: 0x7510792A3B1969F9307F3845CE88e39578f2bAE1 , chain: Ethereum

- Arbitrum One:
  - sender: 0x9203cE1BcdEd1a20f697E1780Bc47d5B6D718031
  - cBridge: 0x1619DE6B6B20eD217a58d00f37B9d47C7663feca
  - pegged_uniETH: 0x3d15fD46CE9e551498328B1C83071D9509E2C3a0
  - messageBug: 0x3ad9d0648cdaa2426331e894e980d0a5ed16257f
  - WETH: 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1

- Linea:
  - sender: 0x4c94cfa2F41e50638A2bEd0dDe672fa8B5d070c8
  - cBridge: 0x9B36f165baB9ebe611d491180418d8De4b8f3a1f
  - pegged_uniETH: 0x15EEfE5B297136b8712291B632404B66A8eF4D25
  - messageBug: 0x6F2bD3Dec1A8c4459c2acC318881F63A048c7c28
  - WETH: 0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f

- Scroll:
  - sender: 0x6b9a24F96A71F9a3008B4beACf729180369C245D
  - cBridge: 0x9B36f165baB9ebe611d491180418d8De4b8f3a1f
  - pegged_uniETH: 0x15EEfE5B297136b8712291B632404B66A8eF4D25
  - messageBug: 0x7d43AABC515C356145049227CeE54B608342c0ad
  - WETH: 0x5300000000000000000000000000000000000004

- xLayer:
  - sender: 0x4c94cfa2F41e50638A2bEd0dDe672fa8B5d070c8
  - cBridge: 0x9B36f165baB9ebe611d491180418d8De4b8f3a1f
  - pegged_uniETH: 0x15EEfE5B297136b8712291B632404B66A8eF4D25
  - messageBug: 0x265B25e22bcd7f10a5bD6E6410F10537Cc7567e8
  - WETH: 0x5a77f1443d16ee5761d310e38b62f77f726bc71c
