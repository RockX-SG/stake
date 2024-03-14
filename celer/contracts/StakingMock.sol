// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../interfaces/iface.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MockUniETH is ERC20, Ownable {
    constructor()
        ERC20("uniETH", "uniETH")
        Ownable()
    {}

    // @dev mintable group
    mapping(address => bool) public mintableGroup;
    modifier onlyMintableGroup() {
        require(mintableGroup[msg.sender], "uniETH: not in mintable group");
        _;
    }

    /**
     * @dev set or remove address to mintable group
     */
    function setMintable(address account, bool allow) public onlyOwner {
        require(mintableGroup[account] != allow, "already set");
        mintableGroup[account] = allow;
    }

    function mint(address to, uint256 amount) public onlyMintableGroup {
        _mint(to, amount);
    }
}

contract MockStaking {
    using SafeERC20 for IERC20;
    address public immutable token;

    constructor(address _token) {
        token = _token;
    }

    function mint( uint256 minToMint, uint256 deadline) external payable returns ( uint256 minted ) {
        IMintableContract(token).mint(msg.sender, msg.value);
        return msg.value;
    }
}
