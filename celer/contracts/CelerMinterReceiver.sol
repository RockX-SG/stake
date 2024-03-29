// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@celer-network/contracts/message/framework/MessageApp.sol";
import "../interfaces/iface.sol";

contract CelerMinterReceiver is MessageApp, AccessControl, ReentrancyGuard {
    using SafeERC20 for IERC20;
    using Address for address payable;

    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    /** 
     * @dev the wrapped ETH on this chain
     *  ethereum mainnet: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
     */
    address public immutable WETH;

    /**
     * @dev point to the staking contract 
     *  ethereum mainnet: 0x4beFa2aA9c305238AA3E0b5D17eB20C045269E9d
     */
    address public immutable stakingContract;

    /**
     * @dev point to the celer bridge
     *  ethereum mainnet: 0x5427FEFA711Eff984124bFBB1AB6fbf5E3DA1820
     */
    address public immutable bridgeContract;

    /**
     * @dev the counter for celer transactions
     */
    uint64 public nonce;

    /**
     * @dev a fixed gas fee collection on each cross chain trasnaction for message executor
     */
    uint256 public fixedGasFee;

    /**
     * @dev record accumulated gas fee
     */
    uint256 public accGasFee; 

    receive() external payable { }
    constructor(address _messageBus,
                address _bridgeContract,
                address _weth,
                address _stakingContract
               ) MessageApp(_messageBus) {

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MANAGER_ROLE, msg.sender);

        stakingContract = _stakingContract;
        bridgeContract = _bridgeContract;
        WETH = _weth;
    }

        /**
     * @dev called by MessageBus on the destination chain to receive message with token
     *  transfer, record and emit info.
     *  the associated token transfer is guaranteed to have already been received
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

        // only accept WETH
        if (_token != WETH) {
            emit TokensLocked(sender, _token, _amount);
            return ExecutionStatus.Fail;
        }

        // insufficient gas fee, reject
        if (_amount < fixedGasFee) {
            accGasFee += _amount;
            return ExecutionStatus.Fail;
        }

        // require minting contract not paused
        require(!IBedrockStaking(stakingContract).paused(), MsgDataTypes.abortReason("Pausable: paused"));

        // split amount to ethersToMint and accGasFee
        uint256 ethersToMint = _amount - fixedGasFee;
        accGasFee += fixedGasFee;

        // mint uniETH
        uint256 minted = IBedrockStaking(stakingContract).mint{value:ethersToMint}(0, type(uint256).max);

        // send uniETH back to sourcechain sender
        address uniETH = IBedrockStaking(stakingContract).xETHAddress();
        IERC20(uniETH).safeIncreaseAllowance(bridgeContract, minted);
        IOriginalTokenVault(bridgeContract).deposit(
            IBedrockStaking(stakingContract).xETHAddress(),
            minted,
            _srcChainId,
            sender,
            nonce++);

        return ExecutionStatus.Success;
    }


    /**
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     * ADMIN
     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     */

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
    function claimGasFee(address recipient) onlyRole(MANAGER_ROLE) nonReentrant external {
        payable(recipient).sendValue(accGasFee);
        emit GasFeeClaimed(accGasFee);
        accGasFee = 0;
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
    event FixedGasFeeSet(uint256 amount);
    event GasFeeClaimed(uint256 amount);
    event LockedEthersClaimed(address recipient, uint256 amount);
    event LockedTokensClaimed(address recipient, address token, uint256 amount);
    event TokensLocked(address recipient, address token, uint256 amount);
}
