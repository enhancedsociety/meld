pragma solidity ^0.4.24;

import "localhost/zeppelin/contracts/access/Roles.sol";
import "./ComplianceRole.sol";

contract HolderRole is ComplianceRole {
    using Roles for Roles.Role;

    event HolderAdded(address indexed account);
    event HolderRemoved(address indexed account);

    Roles.Role private _holders;

    constructor () public {
        _addHolder(msg.sender);
    }

    function isHolder(address account) public view returns (bool) {
        return _holders.has(account);
    }

    function addHolder(address account) public onlyCompliance {
        _addHolder(account);
    }

    // function renounceHolder() public {
    //     _removeHolder(msg.sender);
    // }

    function _addHolder(address account) internal {
        _holders.add(account);
        emit HolderAdded(account);
    }

    function removeHolder(address account) public onlyCompliance {
        _holders.remove(account);
        emit HolderRemoved(account);
    }
}