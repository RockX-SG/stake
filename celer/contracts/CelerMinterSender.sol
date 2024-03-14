// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@celer-network/contracts/message/framework/MessageApp.sol";
import "@celer-network/contracts/message/libraries/MsgDataTypes.sol";
import "../interfaces/iface.sol";

contract CelerMinterSender is MessageApp, Pausable {
    using SafeERC20 for IERC20;
    using Address for address payable;

    /**
     * @dev require the minimal amount to make a cross chain mint
     */
    uint256 public constant MINIMAL_AMOUNT = 0.02 ether;

    /**
     * @dev set to wrapped ETH contract address on source chain
     */
    address public immutable WETH;

    /**
     * @dev set to receiver address
     */
    address public immutable receiver;

    /**
     * @dev set destination chain id
     *  on mainnet: 1
     */
    uint64 public immutable dstChainId;

    /** 
     * @dev if ETH is on like Arbitrum, Optimism, it's is also native token, it will be wrapped
     */
    bool public isNativeWrap;

    /** 
     * @dev a counter to record each crosschain transaction
     */
    uint64 public nonce;


    constructor(address _messageBus, 
                address _WETH, 
                address _receiver, 
                uint64 _dstChainId,
                bool _isNativeWrap
               ) MessageApp(_messageBus) {

        WETH = _WETH;
        receiver = _receiver;
        dstChainId = _dstChainId;
        isNativeWrap = _isNativeWrap;
    }

    /**
     * @dev mint uniETH with WETH on source chain
     */
    function mint(
        uint256 _amount,
        uint32 _maxSlippage
    ) external payable whenNotPaused {
        require(_amount >= MINIMAL_AMOUNT, "TOO_LITTLE");

        IERC20(WETH).safeTransferFrom(msg.sender, address(this), _amount);
        bytes memory message = abi.encode(msg.sender);
        sendMessageWithTransfer(
            receiver,
            WETH,
            _amount,
            dstChainId,
            nonce++,
            _maxSlippage,
            message,
            MsgDataTypes.BridgeSendType.Liquidity,
            msg.value
        );
    }

    /**
     * @dev called by MessageBus on the source chain to handle message with
     *  failed associated token transfer.
     *  the failed token transfer is guaranteed to have already been refunded
     */
    function executeMessageWithTransferRefund(
        address _token,
        uint256 _amount,
        bytes calldata _message,
        address // executor
    ) external payable override onlyMessageBus returns (ExecutionStatus) {
        (address sender) = abi.decode(
            (_message),
            (address)
        );

        if (!isNativeWrap) {
            IERC20(_token).safeTransfer(sender, _amount);
        } else {
            payable(sender).sendValue(_amount);
        }

        emit Refunded(sender, _token, _amount);
        return ExecutionStatus.Success;
    }

    /**
    * ======================================================================================
    * 
    * CONTRCT EVENTS
    *
    * ======================================================================================
    */
 
    event Refunded(
        address sender,
        address token,
        uint256 amount
    );
}
