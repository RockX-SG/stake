// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@celer-network/contracts/message/framework/MessageApp.sol";
import "@celer-network/contracts/libraries/BridgeTransferLib.sol";
import "../interfaces/iface.sol";

contract CelerMinterReceiver is MessageApp, AccessControl, ReentrancyGuard {
    using SafeERC20 for IERC20;
    using Address for address payable;

    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    uint32 public constant MAX_SLIPPAGE = 5000;

    address public immutable WETH;
    address public immutable stakingContract;
    address public immutable tokenContract;
    address public immutable bridgeContract;

    uint64 public nonce;
    uint256 public fixedGasFee;
    uint256 public accGasFee; 

    receive() external payable { }
    constructor(address _messageBus,
                address _bridgeContract,
                address _weth,
                address _stakingContract,
                address _tokenContract
               ) MessageApp(_messageBus) {
        _setupRole(MANAGER_ROLE, msg.sender);

        stakingContract = _stakingContract;
        tokenContract = _tokenContract;
        bridgeContract = _bridgeContract;
        WETH = _weth;
    }

    /**
     * @dev set fixed gas fee for a single cross chain message
     */
    function setFixedGasFee(uint256 _gasFee) external onlyRole(DEFAULT_ADMIN_ROLE) {
        fixedGasFee = _gasFee;
        emit FixedGasFeeSet(fixedGasFee);
    }

    /**
     * @dev claim accumulated gas fee for Message Executor
     */
    function claimGasFee(address recipient) onlyRole(MANAGER_ROLE) external nonReentrant {
        payable(recipient).sendValue(accGasFee);
        emit GasFeeClaimed(accGasFee);
        accGasFee = 0;
    }

    /**
     * @dev called by MessageBus on the destination chain to receive message with token
     *  transfer, record and emit info.
     * the associated token transfer is guaranteed to have already been received
     */
    function executeMessageWithTransfer(
        address, // srcContract
        address _token,
        uint256 _amount,
        uint64 _srcChainId,
        bytes memory _message,
        address // executor
    ) external payable override onlyMessageBus returns (ExecutionStatus) {
        (address sender) = abi.decode(
            (_message),
            (address)
        );

        // insufficient gas fee, reject
        if (_amount < fixedGasFee) {
            return ExecutionStatus.Fail;
        }

        // only accept WETH
        if (_token != WETH) {
            return ExecutionStatus.Fail;
        }

        // split amount to ethersToMint and accGasFee
        uint256 ethersToMint = _amount - fixedGasFee;
        accGasFee += fixedGasFee;

        // mint uniETH
        uint256 minted = IBedrockStaking(stakingContract).mint{value:ethersToMint}(0, type(uint256).max);

        // send uniETH back to sourcechain sender
        BridgeTransferLib.sendTransfer(
            sender,
            tokenContract,
            minted,
            _srcChainId,
            nonce++,
            MAX_SLIPPAGE,
            BridgeTransferLib.BridgeSendType.PegDeposit,
            bridgeContract
        );

        emit Minted(
            sender,
            _token,
            _amount,
            minted,
            _srcChainId
        );

        return ExecutionStatus.Success;
    }

     /**
     * ======================================================================================
     * 
     * CONTRCT EVENTS
     *
     * ======================================================================================
     */
     event FixedGasFeeSet(uint256 amount);
     event GasFeeClaimed(uint256 amount);
     event Minted(
         address sender,
         address token,
         uint256 amount,
         uint256 amountMinted,
         uint64 srcChainId
     );
 
}
