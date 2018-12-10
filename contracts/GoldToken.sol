pragma solidity ^0.4.24;

import "./token/IERC20.sol";
import "../../math/SafeMath.sol";
import "./token/ERC20.sol";
import "./token/ERC20Burnable.sol";
import "./token/ERC20Mintable.sol";
import "./HolderRole.sol";



/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
 * Originally based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 *
 * This implementation emits additional Approval events, allowing applications to reconstruct the allowance status for
 * all accounts just by listening to said events. Note that this isn't required by the specification, and other
 * compliant implementations may not do it.
 */
contract GOLDToken is ERC20, ERC20Mintable, ERC20Burnable {
    using SafeMath for uint256;
    using Roles for Roles.Role

    HolderRole holderRoles;

    constructor (address holderAddr) internal {
        holderRoles = HolderRole(holderaddr);
    }

    /**
    * @dev Transfer token for a specified addresses
    * @param from The address to transfer from.
    * @param to The address to transfer to.
    * @param value The amount to be transferred.
    */
    function _transfer(address from, address to, uint256 value) internal onlyHolder {
        require(to != address(0));

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(from, to, value);
    }

}