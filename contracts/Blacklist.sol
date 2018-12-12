pragma solidity ^0.4.24;

import "localhost/zeppelin/contracts/access/Roles.sol";
import "./ComplianceRole.sol";


contract Blacklist is ComplianceRole {
    using Roles for Roles.Role;

    event BlacklistAdded(address indexed account);
    event BlacklistRemoved(address indexed account);

    Roles.Role private _blacklist;

    modifier onlyBlacklist() {
        require(isBlacklist(msg.sender));
        _;
    }

    function isBlacklist(address account) public view returns (bool) {
        return _blacklist.has(account);
    }

    function addBlacklist(address account) public onlyCompliance {
        _addBlacklist(account);
    }
    
    function removeBlacklist(address account) public onlyCompliance {
        _removeBlacklist(account);
    }

    function _addBlacklist(address account) internal {
        _blacklist.add(account);
        emit BlacklistAdded(account);
    }

    function _removeBlacklist(address account) internal {
        _blacklist.remove(account);
        emit BlacklistRemoved(account);
    }
}