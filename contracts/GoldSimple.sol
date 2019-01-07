pragma solidity ^0.4.25;

import "localhost/zeppelin/contracts/math/SafeMath.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "localhost/zeppelin/contracts/ownership/Ownable.sol";
import "./SimpleCompliance.sol";

contract GOLDSimple is ERC20Detailed, ERC20Burnable, ERC20Mintable, Ownable, SimpleCompliance
    {
        using SafeMath for uint256;

        constructor (string name, string symbol, uint8 decimals) public ERC20Detailed(name, symbol, decimals) {
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
