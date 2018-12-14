pragma solidity ^0.4.25;

import "localhost/zeppelin/contracts/math/SafeMath.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "localhost/zeppelin/contracts/ownership/Ownable.sol";

contract GOLDSimple is ERC20Detailed, ERC20Burnable, ERC20Mintable, Ownable
    {
        using SafeMath for uint256;

        bool internal _WhitelistOnly;

        constructor (string name, string symbol, uint8 decimals) public ERC20Detailed(name, symbol, decimals) {
        	_WhitelistOnly = false;
        }

        // Whitelist Accounts
	    mapping (address => bool) public whitelistAccount;
	    event Whitelisted(address target, bool whitelisted);
	    function whitelistAccount(address target, bool whitelisted) onlyOwner public {
	        whitelistAccount[target] = whitelisted;
	        emit Whitelisted(target, whitelisted);
	    }

	    // Blacklist Accounts
	    mapping (address => bool) public blacklistAccount;
	    event Blacklisted(address target, bool blacklisted);
	    function blacklistAccount(address target, bool blacklisted) onlyOwner public {
	        blacklistAccount[target] = blacklisted;
	        emit Blacklisted(target, blacklisted);
	    }


	    // Toggle WhitelistOnly
	    function toggleWhitelist() public onlyOwner returns (bool) {
	        _WhitelistOnly = !_WhitelistOnly;
	        return _WhitelistOnly;
	    }

	    // Whitelist Status
	    function WhitelistOn() public view returns (bool) {
	        return _WhitelistOnly;
	    }

	    // Ensure Sender is compliant
	    modifier onlycompliant() {
	    require(!blacklistAccount[msg.sender]);
	    if (_WhitelistOnly) {
            require(whitelistAccount[msg.sender]);
        }
	    _;
	    }

	    // CheckCompliance
	    function checkCompliance(address toCheck) internal view {
        require(!blacklistAccount[toCheck]);
        if (_WhitelistOnly) {
        require(whitelistAccount[toCheck]);
        }
	    }

	    // transfer
	    function transfer(address to, uint256 value) public onlycompliant returns (bool) {
        checkCompliance(to);
        super.transfer(to, value);
        return true;
        }

        // transferFrom
        function transferFrom(address from, address to, uint256 value) public onlycompliant returns (bool) {
        checkCompliance(to);
        super.transferFrom(from, to, value);
        return true;
        }

        // mint
        function mint(address to, uint256 value) public onlyMinter onlycompliant returns (bool) {
        checkCompliance(to);
        super.mint(to, value);
        return true;
        }

    }