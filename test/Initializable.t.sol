// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {GrimoireTest} from "./GrimoireTest.sol";
import {MockInitializable} from "./mocks/MockInitializable.sol";

contract OwnableTest is GrimoireTest {
    MockInitializable mock;

    error NotOwner(address owner, address caller);

    /*//////////////////////////////////////////////////////////////
                                SETUP
    //////////////////////////////////////////////////////////////*/

    function setUp() public {
        mock = new MockInitializable();
    }

    /*//////////////////////////////////////////////////////////////
                              UNIT TESTS
    //////////////////////////////////////////////////////////////*/

    function test_initialize() public {
        // Test updateLock cannot be called before initialization
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        mock.updateLock();

        // Initialize
        mock.initialize();
        assertEq(mock.answer(), 42);

        // Update the lock and make sure it works
        mock.updateLock();
        assertEq(mock.lock(), true);

        // Make sure implementation can't be freezed after implementation
        vm.expectRevert(abi.encodeWithSignature("AlreadyInitialized()"));
        mock.freezeImplementation();
    }

    function test_freeze() public {
        mock.freezeImplementation();

        // Test updateLock cannot be called after freeze
        vm.expectRevert(abi.encodeWithSignature("NotInitialized()"));
        mock.updateLock();

        // Test initialized cannot be called after freeze
        vm.expectRevert(abi.encodeWithSignature("AlreadyInitialized()"));
        mock.initialize();
    }
}
