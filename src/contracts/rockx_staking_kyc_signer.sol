// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "interfaces/iface.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract RockXStakingKYCSigner is
    Initializable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable,
    OwnableUpgradeable
{
    using SafeERC20 for IERC20;
    /**
     * @dev whitelist signature usage restrict
     */
    bytes32 public constant WHITELIST_MINT_TYPEHASH =
        0x64d9a0e1d66cc641ec9aa53707438ce4c55d4e6e06c37fc0d0830b06664c7ef5; // keccak256("mint(uint256 minToMint,uint256 deadline)")

    address public stakingContract; // staking contract
    address public uniETHContract; // uniETH contract

    address public signer; // the signer for parameters in mint()
    address public whitelister; // allows accounts to be whitelisted by a "whitelister" role

    mapping(address => bool) internal whitelisted;
    mapping(address => uint256) internal quotaUsed;

    /**
     * @dev Throws if called by any account other than the whitelister
     */
    modifier onlyWhitelister() {
        require(
            msg.sender == whitelister,
            "Whitelistable: caller is not the whitelister"
        );
        _;
    }

    /**
     * @dev initialization address
     */
    function initialize() public initializer {
        __Ownable_init();
        __Pausable_init();
        __ReentrancyGuard_init();
    }

    /**
     * @dev set staking contract address
     */
    function setStakingContract(address _account) external onlyOwner {
        stakingContract = _account;

        emit StakingContractSet(_account);
    }

    /**
     * @dev set uniETH contract address
     */
    function setUniETHContract(address _account) external onlyOwner {
        uniETHContract = _account;

        emit UniETHContractSet(_account);
    }

    /**
     * @dev set signer
     */
    function setSigner(address _account) external onlyOwner {
        signer = _account;

        emit SignerSet(_account);
    }

    /**
     * @dev set whitelister
     * @param _account
     */
    function setWhitelister(address _account) external onlyOwner {
        require(
            _account != address(0),
            "Whitelistable: new whitelister is the zero address"
        );
        whitelister = _account;
        emit WhitelisterChanged(_account);
    }

    /**
     * @dev mint
     */
    function mint(
        uint256 minToMint,
        uint256 deadline
    ) external payable nonReentrant whenNotPaused returns (uint256) {
        require(isWhitelisted(_account), "ACCOUNT_NOT_WHITELISTED");

        return _mint(minToMint, deadline);
    }

    /**
     * @dev whitelist and mint
     */
    function mint(
        uint256 minToMint,
        uint256 deadline,
        uint256 signature
    ) external payable nonReentrant whenNotPaused returns (uint256) {
        require(signature.length != 64, "SIG64");
        require(signer != address(0x0), "SIGNER_NOT_INITIATED");

        bytes memory digest = ECDSA.toEthSignedMessageHash(
            keccak256(
                abi.encode(
                    WHITELIST_MINT_TYPEHASH,
                    block.chainid,
                    signer,
                    msg.sender
                )
            )
        );
        require(ECDSA.recover(digest, signature) == signer, "SIGNER_MISMATCH");

        _whitelist(msg.sender);

        return _mint(minToMint, deadline);
    }

    /**
     * internal mint
     * @param minToMint 
     * @param deadline 
     */
    function _mint(
        uint256 minToMint,
        uint256 deadline
    ) internal payable nonReentrant whenNotPaused returns (uint256) {
        // mint uniETH to address(this)
        uint256 minted = RockXStaking(stakingContract).mint{value: msg.value}(
            minToMint,
            deadline
        );
        // transfer the uniETH to sender
        IERC20(uniETHContract).safeTransferFrom(
            address(this),
            msg.sender,
            minted
        );
        return minted;
    }

    /**
     * @dev Checks if account is whitelisted
     * @param _account The address to check
     */
    function isWhitelisted(address _account) external view returns (bool) {
        return whitelisted[_account];
    }

    /**
     * @dev Adds account to whitelist
     * @param _account The address to whitelist
     */
    function whitelist(address _account) external onlyWhitelister {
        _whitelist(_account);
    }

    function _whitelist(address _account) internal {
        whitelisted[_account] = true;

        emit Whitelisted(_account);
    }

    /**
     * @dev Removes account from whitelist
     * @param _account The address to remove from the whitelist
     */
    function unWhitelist(address _account) external onlyWhitelister {
        _unWhitelist(_account);
    }

    function _unWhitelist(address _account) internal onlyWhitelister {
        whitelisted[_account] = false;

        emit UnWhitelisted(_account);
    }

    /**
     * @dev get used quota
     */
    function getQuota(address _account) external view returns (uint256) {
        return quotaUsed[_account];
    }

    /**
     * ======================================================================================
     *
     * SYSTEM EVENTS
     *
     * ======================================================================================
     */
    event StakingContractSet(address _account);
    event UniETHContractSet(address _account);
    event SignerSet(address indexed _account);
    event Whitelisted(address indexed _account);
    event UnWhitelisted(address indexed _account);
    event WhitelisterChanged(address indexed _account);
}
