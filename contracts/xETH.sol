// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract xETH is ERC20, ERC20Snapshot, Ownable, Pausable {    
    using SafeERC20 for IERC20;
    using SafeMath for uint;
    using Address for address payable;
    using SafeMath for uint256;
    
   /**
     * @dev Emitted when an account is set mintable
     */
    event Mintable(address account);
    /**
     * @dev Emitted when an account is set unmintable
     */
    event Unmintable(address account);
    
    // @dev mintable group
    mapping(address => bool) public mintableGroup;
    
    modifier onlyMintableGroup() {
        require(mintableGroup[msg.sender], "xETH: not in mintable group");
        _;
    }
    
    /**
     * @dev Initialize the contract give all tokens to the deployer
     */
    constructor() ERC20("RockX ETH", "xETH") {
        setMintable(owner(), true); // default mintable at constructor
    }
    
    /**
     * @dev set or remove address to mintable group
     */
    function setMintable(address account, bool allow) public onlyOwner {
        require(mintableGroup[account] != allow, "already set");
        mintableGroup[account] = true;

        if (allow) {
            emit Mintable(account);
        }  else {
            emit Unmintable(account);
        }
    }
    
    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
    function mint(address account, uint256 amount) public onlyMintableGroup {
        _mint(account, amount);
        
    }
    /**
     * @dev Destroys `amount` tokens from the user.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public onlyMintableGroup {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Batch transfer amount to recipient
     * @notice that excessive gas consumption causes transaction revert
     */
    function batchTransfer(address[] memory recipients, uint256[] memory amounts) public {
        require(recipients.length > 0, "xETH: least one recipient address");
        require(recipients.length == amounts.length, "xETH: number of recipient addresses does not match the number of tokens");

        for(uint256 i = 0; i < recipients.length; ++i) {
            _transfer(_msgSender(), recipients[i], amounts[i]);
        }
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}

