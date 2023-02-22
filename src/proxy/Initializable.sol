// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {SlotLib} from "../utils/SlotLib.sol";

abstract contract Initializable {
    /*//////////////////////////////////////////////////////////////
                            CONTRACT STORAGE
    //////////////////////////////////////////////////////////////*/

    bytes32 internal constant INITIALIZATION_STATUS = bytes32(uint256(keccak256("grimoire.initialization.status")) - 1);

    error AlreadyInitialized();
    error NotInitialized();
    
    modifier onlyinitialized {
        if (SlotLib.loadUint256Slot(INITIALIZATION_STATUS) != 1)
            revert NotInitialized();
        _;
    }

    modifier onlyUninitialized {
        if (SlotLib.loadUint256Slot(INITIALIZATION_STATUS) != 0)
            revert AlreadyInitialized();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                          VIRTUAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Initialize function, made virtual to force
    /// the inheriting contract to use it.
    /// @dev you SHOULD override this.
    function initialize() external virtual;

    /*//////////////////////////////////////////////////////////////
                            INTERNAL LOGIC
    //////////////////////////////////////////////////////////////*/

    /// @notice Function that sets the contract as initialized.
    /// Called by the inheriting contract.
    /// @dev This will update the initialization slot to 1, which means initialized.
    function initialized() internal onlyUninitialized {
        SlotLib.setUint256Slot(INITIALIZATION_STATUS, 1);
    }

    /// @notice Function that sets the contract as freezed, meaning it can't be used. Should be used only on the implementation contract.
    /// @dev This will update the initialization slot to type(uint256).max, which means freezed.
    function freeze() internal onlyUninitialized {
        SlotLib.setUint256Slot(INITIALIZATION_STATUS, type(uint256).max);
    }
}