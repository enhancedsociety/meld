pragma solidity ^0.4.24;

import "localhost/zeppelin/contracts/access/Roles.sol";

contract HolderRole {
    using Roles for Roles.Role;

    event HolderAdded(address indexed account);
    event HolderRemoved(address indexed account);

    Roles.Role private _holders;

    constructor () internal {
        _addHolder(msg.sender);
    }

    modifier onlyHolder() {
        require(isHolder(msg.sender));
        _;
    }

    function isHolder(address account) public view returns (bool) {
        return _holders.has(account);
    }

    function addHolder(address account) public onlyHolder {
        _addHolder(account);
    }

    function renounceHolder() public {
        _removeHolder(msg.sender);
    }

    function _addHolder(address account) internal {
        _holders.add(account);
        emit HolderAdded(account);
    }

    function _removeHolder(address account) internal {
        _holders.remove(account);
        emit HolderRemoved(account);
    }
}