pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@axelar-network/interchain-token-service/contracts/interfaces/IInterchainTokenService.sol";
import "../interfaces/IStaking.sol";

contract AxelarMintBridge {
    // Interchain Token Service:
    // mainnet: 0xB5FB4BE02232B1bBA4dC8f81dc24C26980dE9e3C
    // testnet: 0xB5FB4BE02232B1bBA4dC8f81dc24C26980dE9e3C
    address public immutable its;
    address public immutable staking;
    address public immutable uniETH;
    // Token Id:
    // uniETH mainnet: 0x8eabba083434096070ab16f833fec2bc7160bc7cc9ab2ff9ff255bd17b8d36b9;
    // uniETH goerli: 0x9677df2694f7ef453101f3c953aeca2503c25d4ccb8b6850f9a1849dc45ce69f
    bytes32 public immutable tokenId; 

    constructor(address its_, address staking_, address uniETH_, bytes32 tokenId_) {
        its = its_;
        staking = staking_;
        uniETH = uniETH_;
        tokenId = tokenId_;
    }

    // cross chain minter on ITS
    function mint(
        string calldata sourceChain,
        bytes calldata recipient,
        uint256 gasValue
    ) external payable {
        uint256 ethers = msg.value - gasValue;
        uint256 amount = IStaking(staking).mint{value:ethers}(0, type(uint256).max);
        IERC20(uniETH).approve(its, amount);
        IInterchainTokenService(its).interchainTransfer{value:gasValue}(
            tokenId,
            sourceChain,
            recipient,
            amount,
            "",
            gasValue); // how to calc gas value?
    }
}
