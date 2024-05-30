// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SkiToken is ERC20, Ownable {

    mapping(uint256 => uint256) public ItemPrices;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        ItemPrices[1] = 100;
        ItemPrices[2] = 90;
        ItemPrices[3] = 200;
        ItemPrices[4] = 30;
    }

    function mintTokens(address recipient, uint256 amount) external onlyOwner {
      _mint(recipient, amount);
    }

    function transferTokens(address recipient, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Transfer Failed: Not enough balance.");
        _transfer(msg.sender, recipient, amount);
    }

    function viewShopItems() external pure returns (string memory) {
        return "In-stock items: {1} Smiski Bath Series (100 DGN) {2} Smiski T-shirt & Hoodie (90 DGN) {3} Random Smiski Item (200 DGN) {4} Smiski Sticker & Cards (30 DGN)";
    }

    function redeemItem(uint256 itemId) external {
        uint256 price = ItemPrices[itemId];
        require(price > 0, "Item is out of stock.");
        require(balanceOf(msg.sender) >= price, "Redeem Failed: Not enough balance.");
        _transfer(msg.sender, owner(), price);
    }
    
    function burnTokens(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Burn Failed: Not enough balance.");
        _burn(msg.sender, amount);
    }

    function checkBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }
}
