// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@celer-network/contracts/message/framework/MessageApp.sol";
import "@celer-network/contracts/message/libraries/MsgDataTypes.sol";
import "../interfaces/iface.sol";

contract CelerMinterSender is MessageApp, Pausable, ReentrancyGuard, AccessControl {
    using SafeERC20 for IERC20;
    using Address for address payable;

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev the minimal amount to make a cross chain mint
     */
    uint256 public minimalDeposit = 0.02 ether;

    /**
     * @dev set to wrapped ETH contract address on source chain
     */
    address public immutable WETH;

    /**
     * @dev set to receiver address on destination chain
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

    receive() external payable { }
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
     * @dev mint uniETH with WETH on source chain
     */
    function mint(
        uint256 _amount,
        uint32 _maxSlippage,
        address _recipient
    ) public payable whenNotPaused {
        require(_amount >= minimalDeposit, "TOO_LITTLE");

        IERC20(WETH).safeTransferFrom(msg.sender, address(this), _amount);
        _mintInternal(_amount, _maxSlippage, _recipient, msg.value);
    }

    /**
     * @dev mint native ETH on source chain
     */
    function mintEthers(
        uint256 _amount,
        uint32 _maxSlippage,
        address _recipient
    ) external payable {
        require(_amount < msg.value, "INSUFFICIENT_ETHERS");
        require(_amount >= minimalDeposit, "TOO_LITTLE");
        uint256 _fees = msg.value - _amount;
        
        // wrap to WETH or revert here
        IWETH9(WETH).deposit{value:_amount}(); 
        _mintInternal(_amount, _maxSlippage, _recipient, _fees);
    }

    // internal minting, it only handles Wrapped ETH(WETH) received.
    function _mintInternal(uint256 _amount, uint32 _maxSlippage, address _recipient, uint256 _fees) internal {
        bytes memory message = abi.encode(_recipient);
        sendMessageWithTransfer(
            receiver,
            WETH,
            _amount,
            dstChainId,
            nonce++,
            _maxSlippage,
            message,
            MsgDataTypes.BridgeSendType.Liquidity,
            _fees
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
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     * ADMIN
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */
 
    /**
     * @dev set minimal WETH to deposit
     */
    function setMinimalDeposit(uint256 _minimal) external onlyRole(DEFAULT_ADMIN_ROLE) {
        minimalDeposit = _minimal;
        emit MinimalDepositSet(minimalDeposit);
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
     * @dev claim locked ethers in this contract, usually we don't need this,
     *  just in case some failed transaction locked ethers in this contract
     */
    function claimLockedEthers(address recipient, uint256 amount) onlyRole(DEFAULT_ADMIN_ROLE) nonReentrant external {
        payable(recipient).sendValue(amount);
        emit LockedEthersClaimed(recipient, amount);
    }

    /**
     * @dev claim locked tokens in this contract, usually we don't need this,
     *  just in case some failed transaction locked tokens in this contract
     */
    function claimLockedTokens(address token, address recipient, uint256 amount) onlyRole(DEFAULT_ADMIN_ROLE) nonReentrant external {
        IERC20(token).safeTransfer(recipient, amount);
        emit LockedTokensClaimed(recipient, token, amount);
    }

    /**
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     * CONTRCT EVENTS
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */
    event Refunded(
        address sender,
        address token,
        uint256 amount
    );
    event MinimalDepositSet(uint256 amount);
    event LockedEthersClaimed(address recipient, uint256 amount);
    event LockedTokensClaimed(address recipient, address token, uint256 amount);
}
