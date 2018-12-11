pragma solidity ^0.4.24;

import "localhost/zeppelin/contracts/token/ERC20/IERC20.sol";
import "localhost/zeppelin/contracts/math/SafeMath.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Mintable.sol";
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

    HolderRole holderRoles;

    constructor (address holdersAddr) public GOLDToken(holdersAddr) {
        holderRoles = HolderRole(holdersAddr);
    }
    
    /**
    * @dev Transfer token for a specified address
    * @param to The address to transfer to.
    * @param value The amount to be transferred.
    */
    function transfer(address to, uint256 value) public returns (bool) {
        require(holderRoles.isHolder(msg.sender));
        super.transfer(to, value);
        return true;
    }


}