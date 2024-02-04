// SPDX-License-Identifier: MIT
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⢠⣤⣤⣤⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⠉⠻⣿⡟⠛⠛⠻⣿⣄⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⡀⡀⡀⡀⡀⡀⡀⠙⢿⣿⡟⠁⡀⡀⠙⣿⠟⠁
// ⡀⡀⣿⡇⡀⡀⡀⢸⣿⡆⡀⡀⡀⡀⡀⣀⣀⡀⡀⡀⡀⡀⡀⡀⡀⣀⣀⣀⡀⡀⡀⡀⣿⣿⡀⡀⡀⡀⡀⡀⡀⡀⡀⢿⣿⡄⡀⡀⣾⠃⡀⡀
// ⡀⡀⣿⡇⡀⡀⡀⢸⣿⠃⡀⡀⡀⣾⡿⠉⠉⠙⣿⣄⡀⡀⡀⣴⣿⠋⠉⠻⣿⡄⡀⡀⣿⣿⡀⡀⠙⣿⠿⠉⡀⡀⡀⡀⢻⣿⣄⣿⠁⡀⡀⡀
// ⡀⡀⣿⣇⣀⣀⣤⡿⠋⡀⡀⡀⣼⣿⡀⡀⡀⡀⢸⣿⡀⡀⢠⣿⠃⡀⡀⡀⠛⡀⡀⡀⣿⣿⡀⢀⡿⠁⡀⡀⡀⡀⡀⡀⡀⢻⣿⡄⡀⡀⡀⡀
// ⡀⡀⣿⡏⠉⠻⣿⣄⡀⡀⡀⡀⣿⣿⡀⡀⡀⡀⠘⣿⡇⡀⢸⣿⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⣴⣿⣦⡀⡀⡀⡀⡀⡀⡀⢠⡿⢻⣿⡄⡀⡀⡀
// ⡀⡀⣿⡇⡀⡀⠻⣿⣆⡀⡀⡀⢿⣿⡀⡀⡀⡀⢸⣿⠁⡀⢸⣿⡀⡀⡀⡀⡀⡀⡀⡀⣿⣿⡀⠘⣿⣧⡀⡀⡀⡀⡀⣰⡟⡀⡀⢻⣿⡄⡀⡀
// ⡀⢀⣿⣧⡀⡀⡀⠻⣿⣦⡀⡀⠈⣿⣄⡀⡀⡀⣾⡿⡀⡀⡀⢿⣷⡀⡀⡀⣀⡄⡀⡀⣿⣿⡀⡀⠈⣿⣷⡀⡀⡀⣴⣿⡀⡀⡀⡀⢻⣿⣄⡀
// ⠛⠛⠛⠛⠛⡀⡀⡀⠈⠛⠛⡀⡀⡀⠛⠿⠿⠟⠋⡀⡀⡀⡀⡀⠙⠿⠿⠿⠛⡀⠘⠛⠛⠛⠛⡀⡀⡀⠙⠛⠛⠛⠛⠛⠛⡀⡀⠛⠛⠛⠛⠛
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀
// ⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀⡀

pragma solidity ^0.8.4;

import "interfaces/iface.sol";
import "@eigenlayer/contracts/interfaces/IEigenPodManager.sol";
import "@eigenlayer/contracts/interfaces/IDelayedWithdrawalRouter.sol";
import "@eigenlayer/contracts/interfaces/IEigenPod.sol";
import "@eigenlayer/contracts/libraries/BeaconChainProofs.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

/**
 * @title RockX EigenLayer Restaking Contract
 *
 * Description:
 *  This contract manages restaking on eigenlayer, including:
 *      1. createPod for native staking
 *      2. withdraws rewards from eigenpod to staking contract.
 */
contract RockXRestaking is Initializable, AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    using Address for address payable;

    bytes32 public constant OPERATOR_ROLE= keccak256("OPERATOR_ROLE");
    uint256 public constant WITHDRAW_MIN = 0.01 ether;

    /// @dev the EigenLayer EigenPodManager contract
    address public eigenPodManager;
    /// @dev The EigenPod owned by this contract
    address public eigenPod;
    /// @dev the DelegationManager contract
    address public delegationManager;
    /// @dev the StrategyManager contract
    address public strategyManager;
    /// @dev the DelayedWithdrawalRouter contract
    address public delayedWithdrawalRouter;
    /// @dev record pending withdrawal amount from EigenPod to DelayedWithdrawalRouter 
    uint256 private pendingWithdrawal;
    // @dev staking contract address
    address public stakingAddress;
    
    /**
     * @dev empty reserved space for future adding of variables
     */
    uint256[30] private __gap;

    /**
     * @dev forward to staking contract
     */
    receive() external payable { }
    constructor() { _disableInitializers(); }

    /**
     * @dev initialization 
     */
    function initialize(
        address _eigenPodManager,
        address _delegationManager,
        address _strategyManager,
        address _delayedWithdrawalRouter
    ) initializer public {
        require(_eigenPodManager != address(0x0), "SYS026");
        require(_delegationManager!= address(0x0), "SYS027");
        require(_strategyManager!= address(0x0), "SYS028");
        require(_delayedWithdrawalRouter!= address(0x0), "SYS029");

        __AccessControl_init();
        __ReentrancyGuard_init();

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(OPERATOR_ROLE, msg.sender);

        // Assign to local variable
        eigenPodManager = _eigenPodManager;
        delegationManager = _delegationManager;
        strategyManager = _strategyManager;
        delayedWithdrawalRouter = _delayedWithdrawalRouter;

        // Deploy new EigenPod
        IEigenPodManager(eigenPodManager).createPod();

        // Save off the EigenPod address
        eigenPod = address(IEigenPodManager(eigenPodManager).getPod(address(this)));
    }

    /**
     * UPDATE(20240130): to set a variable after upgrades
     * use upgradeAndCall to initializeV2
     */ 
    function initializeV2(address stakingAddress_) reinitializer(2) public {
        stakingAddress = stakingAddress_;
    }

       /// @notice Called by the pod owner to withdraw the balance of the pod when `hasRestaked` is set to false
    function withdrawBeforeRestaking() external {
        if (eigenPod.balance < WITHDRAW_MIN) {
            return;
        }

        uint256 balanceBefore = address(eigenPod).balance;
        IEigenPod(eigenPod).withdrawBeforeRestaking();
        uint256 diff = balanceBefore - address(eigenPod).balance;
        pendingWithdrawal += diff;
        emit Pending(diff);
    }

    /**
     * @notice Called in order to withdraw delayed withdrawals made to the caller that have passed the `withdrawalDelayBlocks` period.
     * @param maxNumberOfWithdrawalsToClaim Used to limit the maximum number of withdrawals to loop through claiming.
     */
    function claimDelayedWithdrawals(
        uint256 maxNumberOfWithdrawalsToClaim
    ) external nonReentrant {
        if (IDelayedWithdrawalRouter(delayedWithdrawalRouter).getClaimableUserDelayedWithdrawals(address(this)).length == 0) {
            return;
        }

        uint256 balanceBefore = address(this).balance;
        IDelayedWithdrawalRouter(delayedWithdrawalRouter).claimDelayedWithdrawals(maxNumberOfWithdrawalsToClaim);
        uint256 diff = address(this).balance - balanceBefore;

        // nothing to be done here
        if (diff == 0) {
            return;
        }

        pendingWithdrawal -= diff;
        // forward to staking address
        payable(stakingAddress).sendValue(diff); 
        emit Claimed(diff);
    }

    /**
     * @dev get amount withdrawed from eigenpod to IDelayedRouter
     */
    function getPendingWithdrawalAmount(
    ) external view returns (uint256) {
        return pendingWithdrawal;
    }

    /**
     * ======================================================================================
     * 
     * EVENTS
     *
     * ======================================================================================
     */
    event Claimed(uint256 amount);
    event Pending(uint256 amount);
}
