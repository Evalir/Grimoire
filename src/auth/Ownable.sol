// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {ERC173} from "./IERC173.sol";
import {ERC165} from "../interface/IERC165.sol";
import {SlotLib} from "../utils/SlotLib.sol";

/// @title Ownable
/// @author Enrique Ortiz @Evalir
/// @notice Simple owner authorization contract. Saves the owner address in a slot to avoid
/// storage slot collisions.
contract Ownable is ERC173, ERC165 {
    /*//////////////////////////////////////////////////////////////
                              CONSTANTS
    //////////////////////////////////////////////////////////////*/
    bytes32 internal constant ERC173_OWNER_SLOT = bytes32(uint256(keccak256("erc173.owner")) - 1);

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/
    error NotOwner(address owner, address caller);

    modifier onlyOwner() virtual {
        // Cache the owner address in memory to save on SLOADs.
        address _owner = SlotLib.loadAddressSlot(ERC173_OWNER_SLOT);
        if (msg.sender != _owner)
            revert NotOwner(_owner, msg.sender);
        _;
    }

    /*//////////////////////////////////////////////////////////////
                             CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    constructor(address _owner) {
        SlotLib.setAddressSlot(ERC173_OWNER_SLOT, _owner);
        emit OwnershipTransferred(address(0), _owner);
    }

    /*//////////////////////////////////////////////////////////////
                            EXTERNAL LOGIC
    //////////////////////////////////////////////////////////////*/
    function owner() external view override returns (address) {
        return SlotLib.loadAddressSlot(ERC173_OWNER_SLOT);
    }

    function transferOwnership(address _newOwner) external override {
        address _owner = SlotLib.loadAddressSlot(ERC173_OWNER_SLOT);
        if (msg.sender != _owner) {
            revert NotOwner(_owner, msg.sender);
        }
        SlotLib.setAddressSlot(ERC173_OWNER_SLOT, _newOwner);
        emit OwnershipTransferred(_owner, _newOwner);
    }

    /*//////////////////////////////////////////////////////////////
                                ERC165
    //////////////////////////////////////////////////////////////*/
    function supportsInterface(bytes4 interfaceID) external pure returns (bool) {
        return interfaceID == 0x7f5828d0;
    }
}
