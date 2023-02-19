// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {GrimoireTest} from "./GrimoireTest.sol";
import {MockOwnable} from "./mocks/MockOwnable.sol";

contract OwnableTest is GrimoireTest {
    /*//////////////////////////////////////////////////////////////
                            EVENT STORAGE
    //////////////////////////////////////////////////////////////*/

    MockOwnable mock;

    /*//////////////////////////////////////////////////////////////
                            TEST CASES
    //////////////////////////////////////////////////////////////*/

    error NotOwner(address owner, address caller);

    /*//////////////////////////////////////////////////////////////
                                SETUP
    //////////////////////////////////////////////////////////////*/

    function setUp() public {
        mock = new MockOwnable();
    }

    /*//////////////////////////////////////////////////////////////
                              UNIT TESTS
    //////////////////////////////////////////////////////////////*/

    function test_transferOwnership() public {
        address newOwner = address(0xDEADBEEF);
        mock.transferOwnership(newOwner);
        assertEq(mock.owner(), newOwner);
    }

    function test_callWhileNotOwner() public {
        address notOwner = address(0xDEADBEEF);
        vm.prank(notOwner);

        vm.expectRevert(abi.encodeWithSignature("NotOwner(address,address)", address(this), notOwner));
        mock.updateLock();
    }

    function test_callWhileOwner() public {
        mock.updateLock();
        assertTrue(mock.lock());
    }
}
