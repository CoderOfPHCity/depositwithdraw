// // SPDX-License-Identifier: MIT
pragma solidity ^0.8;


pragma solidity ^0.8.0;


contract DepositWithdraw {


    mapping(address => mapping(address => uint256)) tokenBalances;

    function deposit(address token, uint256 amount) external payable {
        require( msg.value > 0, "not enough deposit");

            tokenBalances[msg.sender][address(0)] += msg.value;
            require(amount > 0, "Cannot deposit zero tokens");
           
            tokenBalances[msg.sender][token] += amount;
        }

    function withdraw(address token,address _to, uint256 amount) external {
        require( amount > 0, "bnot enough");
        
            tokenBalances[msg.sender][_to] -= amount;
            payable(msg.sender).transfer(amount);
            require(tokenBalances[msg.sender][token] >= amount, "Insufficient e");
            tokenBalances[msg.sender][token] -= amount;
        }

    function getBalance(address token) external view returns (uint256) {
        return token == address(0) ? tokenBalances[msg.sender][address(0)] : tokenBalances[msg.sender][token];
    }
}