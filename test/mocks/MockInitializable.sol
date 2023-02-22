// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Initializable} from "../../src/proxy/Initializable.sol";

contract MockInitializable is Initializable {
    bool public lock = false;
    uint256 public answer = 41;
    address owner;

    error NotOwner(address owner, address caller);

    modifier onlyOwner {
        if (msg.sender != owner) {
            revert NotOwner(owner, msg.sender);
        }
        _;
    }

    function updateLock() external onlyInitialized {
        lock = true;
    }

    function initialize() external {
        answer = 42;
        owner = msg.sender;
        initialized();
    }

    function freezeImplementation() external onlyUninitialized {
        freeze();
    }
}