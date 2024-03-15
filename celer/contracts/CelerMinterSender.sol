// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@celer-network/contracts/message/framework/MessageApp.sol";
import "@celer-network/contracts/message/libraries/MsgDataTypes.sol";
import "../interfaces/iface.sol";

contract CelerMinterSender is MessageApp, Pausable, AccessControl {
    using SafeERC20 for IERC20;
    using Address for address payable;

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev require the minimal amount to make a cross chain mint
     */
    uint256 public MINIMAL_DEPOSIT = 0.02 ether;

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

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(PAUSER_ROLE, msg.sender);

        WETH = _WETH;
        receiver = _receiver;
        dstChainId = _dstChainId;
        isNativeWrap = _isNativeWrap;
    }

    /**
     * @dev set minimal WETH to deposit
     */
    function setMinimalDeposit(uint256 _minimal) external onlyRole(DEFAULT_ADMIN_ROLE) {
        MINIMAL_DEPOSIT = _minimal;
        emit MinimalDepositSet(MINIMAL_DEPOSIT);
    }

    /**
     * @dev pause the contract
     */
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev unpause the contract
     */
    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @dev mint uniETH with WETH on source chain
     */
    function mint(
        uint256 _amount,
        uint32 _maxSlippage
    ) external payable whenNotPaused {
        require(_amount >= MINIMAL_DEPOSIT, "TOO_LITTLE");

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
     * CONTRCT EVENTS
     */
    event Refunded(
        address sender,
        address token,
        uint256 amount
    );
    event MinimalDepositSet(uint256 amount);
}
