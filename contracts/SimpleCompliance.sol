pragma solidity ^0.4.25;

import "localhost/zeppelin/contracts/ownership/Ownable.sol";


contract SimpleCompliance is Ownable {

    bool _WhitelistOnly = false;

    // Toggle WhitelistOnly
    function toggleWhitelist() public onlyOwner returns (bool) {
        _WhitelistOnly = !_WhitelistOnly;
        return _WhitelistOnly;
    }

    // Show WhitelistOn Status
    function WhitelistOn() public view returns (bool) {
        return _WhitelistOnly;
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

}
