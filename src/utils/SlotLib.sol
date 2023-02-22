// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/// @title SlotLib
/// @author Enrique Ortiz @Evalir
/// @notice A library for loading and storing data in storage slots, with a certain type.
library SlotLib {
    /*//////////////////////////////////////////////////////////////
                           GETTER FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Loads an address from a storage slot.
    /// Note that this function performs NO sanity checks, for the sake of efficiency.
    /// @param slot The storage slot to load from.
    function loadAddressSlot(bytes32 slot) internal view returns (address data) {
        assembly {
            data := sload(slot)
        }
    }

    /// @notice Loads an uint256 from a storage slot.
    /// Note that this function performs NO sanity checks, for the sake of efficiency.
    /// @param slot The storage slot to load from.
    function loadUint256Slot(bytes32 slot) internal view returns (uint256 data) {
        assembly {
            data := sload(slot)
        }
    }

    /// @notice Loads an bytes32 from a storage slot.
    /// Note that this function performs NO sanity checks, for the sake of efficiency.
    /// @param slot The storage slot to load from.
    function loadBytes32Slot(bytes32 slot) internal view returns (bytes32 data) {
        assembly {
            data := sload(slot)
        }
    }

    /*//////////////////////////////////////////////////////////////
                           SETTER FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// @notice Saves an address to a storage slot.
    /// Note that this function performs NO sanity checks, for the sake of efficiency.
    /// @param slot The storage slot to store to.
    /// @param data The data to save in the storage slot.
    function setAddressSlot(bytes32 slot, address data) internal {
        assembly {
            sstore(slot, data)
        }
    }

    /// @notice Saves an uint256 to a storage slot.
    /// @param slot The storage slot to store to.
    /// @param data The data to save in the storage slot.
    function setUint256Slot(bytes32 slot, uint256 data) internal {
        assembly {
            sstore(slot, data)
        }
    }

    /// @notice Saves an bytes32 to a storage slot.
    /// @param slot The storage slot to store to.
    /// @param data The data to save in the storage slot.
    function setBytes32Slot(bytes32 slot, bytes32 data) internal {
        assembly {
            sstore(slot, data)
        }
    }
}
