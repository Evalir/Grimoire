// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/// @title BytesDataLib
/// @author Enrique Ortiz @Evalir
/// @notice Easily convert from an arbitrary amount of bytes to another type.
library BytesDataLib {
    function bytesToAddress(bytes memory data) internal pure returns (address) {
        return address(uint160(uint256(bytes32(data))));
    }

    function bytesToUint256(bytes memory data) internal pure returns (uint256) {
        return uint256(bytes32(data));
    }
}
