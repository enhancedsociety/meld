pragma solidity ^0.4.25;

import "localhost/zeppelin/contracts/ownership/Ownable.sol";


contract SimpleCompliance is Ownable {


    // frozenAccounts
    mapping (address => bool) public frozenAccount;
    event FrozenFunds(address target, bool frozen);
    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
    }

    // approvedAccounts
    mapping (address => bool) public approvedAccount;
    event ApprovedFunds(address target, bool frozen);
    function approveAccount(address target, bool freeze) onlyOwner public {
        approvedAccount[target] = freeze;
        emit ApprovedFunds(target, freeze);
    }

    // Called by compliant transfer function 
    modifier onlycompliant() {
        require(!frozenAccount[msg.sender]);
        require(approvedAccount[msg.sender]);
        _;
    }
    
    
    
}