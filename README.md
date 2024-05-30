# AVAX-Module-4-Project

SkiToken Smart Contract
Overview
The SkiToken contract is an ERC20 token named "Degen" with the symbol "DGN". It allows the owner to mint new tokens and includes functionalities for users to transfer tokens, view shop items, redeem items, burn tokens, and check their balance. This contract also supports zero decimal places, meaning the smallest unit of the token is 1 DGN.

Prerequisites
Ensure you have Node.js and npm installed.
Install Truffle and Ganache for local Ethereum blockchain development and testing.
Install OpenZeppelin Contracts library.

npm install @openzeppelin/contracts


Contract Details
Deployment
The SkiToken contract is designed to be deployed with the OpenZeppelin library.

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


Functions
mintTokens(address recipient, uint256 amount): Mints the specified amount of tokens to the recipient's address. Only the contract owner can call this function.

transferTokens(address recipient, uint256 amount): Transfers the specified amount of tokens from the sender to the recipient.

viewShopItems(): Returns a list of in-stock shop items and their prices.

redeemItem(uint256 itemId): Redeems an item from the shop by transferring the item's price in tokens from the sender to the contract owner.

burnTokens(uint256 amount): Burns the specified amount of tokens from the sender's balance.

checkBalance(): Returns the token balance of the sender.

decimals(): Overrides the default decimals function to return 0, ensuring that tokens have no fractional part.


Usage
Minting Tokens
Only the contract owner can mint tokens. This is done using the mintTokens function:

mintTokens(address recipient, uint256 amount);

Transferring Tokens
Users can transfer tokens to another address using the transferTokens function:

transferTokens(address recipient, uint256 amount);

Viewing Shop Items
Users can view the available shop items and their prices with the viewShopItems function:

viewShopItems();

Redeeming Shop Items
Users can redeem shop items by calling the redeemItem function with the item's ID:

redeemItem(uint256 itemId);

Burning Tokens
Users can burn their tokens, permanently removing them from circulation, using the burnTokens function:

burnTokens(uint256 amount);

Checking Balance
Users can check their token balance with the checkBalance function:

checkBalance();
