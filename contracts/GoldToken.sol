pragma solidity ^0.4.24;

import "localhost/zeppelin/contracts/token/ERC20/IERC20.sol";
import "localhost/zeppelin/contracts/math/SafeMath.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "./HolderRole.sol";
import "./ComplianceRole.sol";
import "./Blacklist.sol";



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
contract GOLDToken is
        ERC20, ERC20Detailed, ERC20Mintable, ERC20Burnable,
        Blacklist, HolderRole {
    using SafeMath for uint256;

    HolderRole internal holderRoles;
    bool internal _enforceHolderlist;
    bool internal _enforceBlacklist;

    mapping (address => mapping (address => uint256)) internal _allowed;

    constructor (string name, string symbol, uint8 decimals)
    public ERC20Detailed(name, symbol, decimals) {
        holderRoles = HolderRole(this);
        _enforceHolderlist = false;
    //    _enforceBlacklist = true;
    }

    /**
    * @dev Set the holderlist to consult for checking.
    */
    function setHolders(address holdersAddr) public onlyCompliance {
        holderRoles = HolderRole(holdersAddr);
    }

    /**
    * @dev Toggle the holder list enforcing and return current state.
    */
    function toggleHolderlist() public onlyCompliance returns (bool) {
        _enforceHolderlist = !_enforceHolderlist;
        return _enforceHolderlist;
    }

    /**
    * @dev Check whether the holder list is being enforced.
    */
    function getEnforceHolderlist() public view returns (bool) {
        return _enforceHolderlist;
    }

    /**
    * @dev Toggle the blacklist enforcing and return current state.
    */
    // function toggleBlacklist() public onlyCompliance returns (bool) {
    //     _enforceBlacklist = !_enforceBlacklist;
    //    return _enforceBlacklist;
    // }

    /**
    * @dev Check whether the blacklist is being enforced.
    */
    // function getEnforceBlacklist() public view returns (bool) {
    //    return _enforceBlacklist;
    // }

    /**
    * @dev Check whether the address is allowed to hold the tokens.
    * @param toCheck The address to check.
    */
    function checkCompliance(address toCheck) internal view {
        require(!isBlacklist(toCheck));
        if(_enforceHolderlist){
            require(holderRoles.isHolder(toCheck));
        }

    }

    /**
    * @dev Transfer token for a specified address
    * @param to The address to transfer to.
    * @param value The amount to be transferred.
    */
    function transfer(address to, uint256 value) public returns (bool) {
        checkCompliance(to);
        super.transfer(to, value);
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another.
     * Note that while this function emits an Approval event, this is not required as per the specification,
     * and other compliant implementations may not emit the event.
     * @param from address The address which you want to send tokens from
     * @param to address The address which you want to transfer to
     * @param value uint256 the amount of tokens to be transferred
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        checkCompliance(to);
        super.transferFrom(from, to, value);
        return true;
    }

    /**
     * @dev Function to mint tokens
     * @param to The address that will receive the minted tokens.
     * @param value The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address to, uint256 value) public onlyMinter returns (bool) {
        checkCompliance(to);
        super.mint(to, value);
        return true;
    }


}