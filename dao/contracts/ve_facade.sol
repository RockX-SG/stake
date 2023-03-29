// SPDX-License-Identifier: AGPL-3.0-or-later
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
pragma solidity ^0.8.9;

import "interfaces/IVotingEscrow.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/Address.sol";

/**
 * @title Rockx Liquid Staking Voting Escrow Facade
 * @author RockX Team
 * @notice this contract aggregates all balances & totalSupplies of voting escrow contracts.
 */

contract VotingEscrowFacade is Initializable, AccessControlUpgradeable {
    bytes32 public constant AUTHORIZED_LOCKER_ROLE = keccak256("AUTHORIZED_LOCKER_ROLE");
    using Address for address;
    
    // Voting token - Checkpointed view only ERC20
    string public name;
    string public symbol;
    uint256 public decimals;

    address [] public veTokens;

    /**
     * @dev This contract will not accept direct ETH transactions.
     */
    receive() external payable {
        revert("Do not send ETH here");
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        string memory _name,
        string memory _symbol,
        uint256 _decimals) initializer public {
        __AccessControl_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        // set token names
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    /**
     * @dev join a voting escrow for aggregation of balance & total supply in voting-escrow contracts
     */
    function joinVotingEscrow(address _veToken) 
        external
        onlyRole(DEFAULT_ADMIN_ROLE) {

        require (_veToken.isContract(), "MUST_BE_CONTRACT");
        for (uint i=0;i<veTokens.length;i++) {
            if (veTokens[i] == _veToken) {
                revert("ALREADY_IN");
            }
        }
        veTokens.push(_veToken);

        emit VotingEscrowJoined(_veToken);
    }

    /**
     * @notice Sum current user voting power
     * @param _account User for which to return the voting power
     * @return power Voting power of user
     */
    function balanceOf(address _account) 
        external 
        view 
        returns (uint256 power) {
            
        for (uint i=0;i<veTokens.length;i++) {
            power += IVotingEscrow(veTokens[i]).balanceOf(_account);
        }
        return power;
    }

    /**
     * @notice Sum users voting power at a given blockNumber
     * @param _account User for which to return the voting power
     * @param _blockNumber Block at which to calculate voting power
     * @return power uint256 Voting power of user
     */
    function balanceOfAt(address _account, uint256 _blockNumber)
        external
        view
        returns (uint256 power) {
        
        for (uint i=0;i<veTokens.length;i++) {
            power += IVotingEscrow(veTokens[i]).balanceOfAt(_account, _blockNumber);
        }
        return power;
    }

    /**
     * @notice Calculate current total supply of voting power
     * @return Current totalSupply
     */
    function totalSupply() 
        external 
        view 
        returns (uint256) {
        
        uint256 ts;
        for (uint i=0;i<veTokens.length;i++) {
            ts += IVotingEscrow(veTokens[i]).totalSupply();
        }
        return ts;
    }

    /// @notice Calculate total supply of voting power at a given blockNumber
    /// @param _blockNumber Block number at which to calculate total supply
    /// @return totalSupply of voting power at the given blockNumber
    function totalSupplyAt(uint256 _blockNumber)
        external
        view
        returns (uint256) {
        
        uint256 ts;
        for (uint i=0;i<veTokens.length;i++) {
            ts += IVotingEscrow(veTokens[i]).totalSupplyAt(_blockNumber);
        }
        return ts;
    }

    event VotingEscrowJoined(address veToken);
}