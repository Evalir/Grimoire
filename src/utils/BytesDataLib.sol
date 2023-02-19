// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

library BytesDataLib {
    function bytesToAddress(bytes memory data) internal pure returns (address) {
        return address(uint160(uint256(bytes32(data))));
    }

    function bytesToUint256(bytes memory data) internal pure returns (uint256) {
        return uint256(bytes32(data));
    }
}
