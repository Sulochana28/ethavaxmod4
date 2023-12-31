// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event TokenRedeem(address account, uint chooseOption);
    event TokenBurn(address account, uint amount);
    event TokenTransfer(address from, address to, uint amount);

    
    function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }

    function transfer(address to, uint256 amount) public virtual override  returns (bool) {
        _transfer(_msgSender(), to, amount);
        approve(msg.sender, amount);
        return true;
    }
    function checkBalance() external view returns(uint){
           return balanceOf(msg.sender);
        }

    function redeem(uint chooseOption) public {
        uint requiredToken = chooseOption * 10;
        require(balanceOf(msg.sender)>=requiredToken,"ER20 tokens are not enough");
        burn(requiredToken);
        emit TokenRedeem(msg.sender, chooseOption);
    }


    function burn(uint amount) public {
        _burn(msg.sender, amount);
        emit TokenBurn(msg.sender, amount);
    }
}

