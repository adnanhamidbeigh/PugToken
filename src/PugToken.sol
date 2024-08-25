// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
contract PugToken is ERC20, Ownable {
    constructor(uint256 initalSupply) ERC20("PugToken", "PUG") Ownable(msg.sender) {
        _mint(msg.sender, initalSupply);
    }

    function mint(uint256 amount) onlyOwner public {
        _mint(msg.sender, amount);
    }
    function burn(uint256 amount) onlyOwner public {
        _burn(msg.sender, amount);
    }
}