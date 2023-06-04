// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "interfaces/iface.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract RockXStakingKYCSigner is
    Initializable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable,
    AccessControlUpgradeable
{
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    /**
     * @dev whitelist signature usage restrict
     */
    bytes32 public constant WHITELIST_MINT_TYPEHASH =
        0x64d9a0e1d66cc641ec9aa53707438ce4c55d4e6e06c37fc0d0830b06664c7ef5; // keccak256("mint(uint256 minToMint,uint256 deadline)")

    address public uniETHContract; // uniETH contract
    address public stakingContract; // staking contract

    address public signer; // the signer for parameters in mint()

    mapping(address => uint256) internal _allowed;
    mapping(address => uint256) private _mintNonces;

    /**
     * @dev empty reserved space for future adding of variables
     */
    uint256[32] private __gap;

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

    receive() external payable {}

    /**
     * @dev initialization address
     */
    function initialize(
        address _uniETHContract,
        address _stakingContract
    ) public initializer {
        __Pausable_init();
        __AccessControl_init();
        __ReentrancyGuard_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MANAGER_ROLE, msg.sender);

        setUniETHContract(_uniETHContract);
        setStakingContract(_stakingContract);

        setSigner(msg.sender);
    }

    /**
     * @dev set staking contract address
     */
    function setStakingContract(
        address _account
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        stakingContract = _account;

        emit StakingContractSet(_account);
    }

    /**
     * @dev set uniETH contract address
     */
    function setUniETHContract(
        address _account
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        uniETHContract = _account;

        emit UniETHContractSet(_account);
    }

    /**
     * @dev set signer
     */
    function setSigner(address _account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        signer = _account;

        emit SignerSet(_account);
    }

    /**
     * @notice Nonces for mint
     * @return Next nonce
     */
    function nonces(address _account) external view returns (uint256) {
        return _mintNonces[_account];
    }

    /**
     * @dev mint
     */
    function mint(
        uint256 minToMint,
        uint256 deadline
    ) external payable nonReentrant whenNotPaused returns (uint256) {
        require(msg.value <= _allowed[msg.sender], "NEED_KYC_FOR_MORE");
        uint256 minted = _mint(minToMint, deadline);
        _allowed[msg.sender] = _allowed[msg.sender].sub(msg.value);
        return minted;
    }

    /**
     * @dev whitelist and mint
     */
    function mintWithSig(
        uint256 minToMint,
        uint256 deadline,
        uint256 newAllowance,
        bytes calldata signature
    ) external payable nonReentrant whenNotPaused returns (uint256) {
        require(deadline > block.timestamp, "TRANSACTION_EXPIRED");
        require(signature.length != 64, "SIGNATURE_LENGTH_NOT_MATCH");
        require(signer != address(0x0), "SIGNER_NOT_SET");
        require(newAllowance >= msg.value, "ALLOWANCE_INVALID");
        require(
            verifySigner(msg.sender, newAllowance, signature),
            "SIGNER_MISMATCH"
        );
        _mintNonces[msg.sender]++;
        uint256 minted = _mint(minToMint, deadline);
        _allowed[msg.sender] = newAllowance.sub(msg.value);
        return minted;
    }

    /**
     * @dev verify signer of the paramseters
     */
    function verifySigner(
        address spender,
        uint256 newAllowance,
        bytes calldata signature
    ) public view returns (bool) {
        bytes32 digest = ECDSA.toEthSignedMessageHash(
            keccak256(
                abi.encode(
                    WHITELIST_MINT_TYPEHASH,
                    block.chainid,
                    spender,
                    // avoid signature reuse
                    _mintNonces[spender],
                    newAllowance
                )
            )
        );
        return (ECDSA.recover(digest, signature) == signer);
    }

    /**
     * internal staking contract mint
     */
    function _mint(
        uint256 minToMint,
        uint256 deadline
    ) internal whenNotPaused returns (uint256) {
        // mint uniETH to address(this)
        uint256 minted = IRockXStaking(stakingContract).mint{value: msg.value}(
            minToMint,
            deadline
        );
        // transfer the uniETH to sender
        IERC20(uniETHContract).safeTransfer(msg.sender, minted);

        emit Minted(msg.sender, minted, msg.value);

        return minted;
    }

    /**
     *
     */
    function allowance(address _account) external view returns (uint256) {
        return _allowed[_account];
    }

    /**
     * @notice set the allowance
     */
    function setAllowance(
        address _account,
        uint256 value
    ) external whenNotPaused onlyRole(MANAGER_ROLE) returns (bool) {
        _allowed[_account] = value;
        emit AllowanceSet(_account, value);
        return true;
    }

    /**
     * ======================================================================================
     *
     * SYSTEM EVENTS
     *
     * ======================================================================================
     */
    event StakingContractSet(address account);
    event UniETHContractSet(address account);
    event SignerSet(address indexed account);
    event AllowanceSet(address indexed account, uint256 value);
    event Minted(address indexed account, uint256 amount, uint256 value);
}
