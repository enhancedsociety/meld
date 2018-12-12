pragma solidity ^0.4.24;

import "localhost/zeppelin/contracts/access/Roles.sol";


contract ComplianceRole {
    using Roles for Roles.Role;

    event ComplianceAdded(address indexed account);
    event ComplianceRemoved(address indexed account);

    Roles.Role private _compliances;

    constructor () internal {
        _addCompliance(msg.sender);
    }

    modifier onlyCompliance() {
        require(isCompliance(msg.sender));
        _;
    }

    function isCompliance(address account) public view returns (bool) {
        return _compliances.has(account);
    }

    function addCompliance(address account) public onlyCompliance {
        _addCompliance(account);
    }

    function renounceCompliance() public {
        _removeCompliance(msg.sender);
    }

    function _addCompliance(address account) internal {
        _compliances.add(account);
        emit ComplianceAdded(account);
    }

    function _removeCompliance(address account) internal {
        _compliances.remove(account);
        emit ComplianceRemoved(account);
    }
}
