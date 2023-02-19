// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Ownable} from "../../src/auth/Ownable.sol";

contract MockOwnable is Ownable(msg.sender) {
    bool public lock = false;

    function updateLock() external onlyOwner {
        lock = true;
    }
}
