pragma solidity ^0.8.9;

import { IAxelarGateway } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol';
import { IAxelarGasService } from '@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGasService.sol';
import "../interfaces/IStaking.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract AxelarMintingBridge {
    IAxelarGateway public immutable gateway;
    address public staking;
    address public uniETH;
    string constant symbol = "uniETH";

    constructor(address gateway_, address staking_, address uniETH_) {
        gateway = IAxelarGateway(gateway_);
        staking = staking_;
        uniETH = uniETH_;
    }

    // crosschain minter
    function mint(
        string calldata sourceChain,
        bytes calldata payload,
        string calldata recipient
    ) external payable {
        uint256 minted = IStaking(staking).mint{value:msg.value}(0, type(uint256).max);
        IERC20(uniETH).approve(address(gateway), minted);
        gateway.sendToken(sourceChain, recipient, symbol, minted);
    }
}
