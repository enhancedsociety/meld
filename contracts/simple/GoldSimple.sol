pragma solidity ^0.4.25;

import "localhost/zeppelin/contracts/math/SafeMath.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "localhost/zeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "./SimpleCompliance.sol";

contract GOLDSimple is ERC20Detailed, ERC20Burnable, ERC20Mintable, SimpleCompliance
    {
        using SafeMath for uint256;
        
        constructor (string name, string symbol, uint8 decimals)
        public ERC20Detailed(name, symbol, decimals) {
        }
    
        function _complianttransfer(address to, uint256 value) onlycompliant public {
            transfer(to, value);
        }
    }