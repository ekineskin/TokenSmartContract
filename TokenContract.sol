// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenContract {
    mapping(address => uint256) private balances;
    mapping(address => bool) private reentrantGuard;

    event Transfer(address indexed from, address indexed to, uint256 value);

    modifier noReentrant() {
        require(!reentrantGuard[msg.sender], "Reentrant call detected");
        reentrantGuard[msg.sender] = true;
        _;
        reentrantGuard[msg.sender] = false;
    }

    function transfer(address to, uint256 amount) external noReentrant {
        require(to != address(0), "Transfer to the zero address");
        require(balances[msg.sender] >= amount, "Not enough tokens");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }
}
