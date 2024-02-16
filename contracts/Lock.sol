// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DepositWithdraw {
    mapping(address => mapping(address => uint256)) tokenBalances;

    function deposit(address token, uint256 amount) external payable {
        require(msg.value > 0 || amount > 0, "Invalid deposit");
        
        if (token == address(0)) {
            tokenBalances[msg.sender][address(0)] += msg.value;
        } else {
            tokenBalances[msg.sender][token] += amount;
        }
    }

    function withdraw(address token, uint256 amount) external {
        require(amount > 0, "Invalid withdrawal");
        
        if (token == address(0)) {
            require(tokenBalances[msg.sender][address(0)] >= amount, "Insufficient Ether balance");
            tokenBalances[msg.sender][address(0)] -= amount;
            payable(msg.sender).transfer(amount);
        } else {
            require(tokenBalances[msg.sender][token] >= amount, "Insufficient token balance");
            tokenBalances[msg.sender][token] -= amount;
        }
    }

    function getBalance(address token) external view returns (uint256) {
        return token == address(0) ? tokenBalances[msg.sender][address(0)] : tokenBalances[msg.sender][token];
    }
}
