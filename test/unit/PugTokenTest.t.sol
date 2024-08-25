// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployPugToken} from "script/DeployPugToken.s.sol";
import {PugToken} from "src/PugToken.sol";
import {Constants} from "script/Constants.s.sol";

contract PugTokenTest is Test, Constants {
    DeployPugToken deployer;
    PugToken pugToken;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address harry = makeAddr("harry");

    function setUp() public {
        deployer = new DeployPugToken();
        pugToken = deployer.run();
    }

    /*//////////////////////////////////////////////////////////////
                           CONSTRUCTOR TESTS
    //////////////////////////////////////////////////////////////*/

    function testNameAndSymbolOfTokenIsCorrect() public view {
        assertEq(pugToken.name(), "PugToken");
        assertEq(pugToken.symbol(), "PUG");
    }

    function testOwnerIsCorrect() public view {
        assertEq(pugToken.owner(), msg.sender);
    }

    function testInitialSupplyCreditedToOwner() public view {
        assertEq(pugToken.balanceOf(msg.sender), INITIAL_SUPPLY);
    }

    function testTransferPug() public {
        vm.prank(msg.sender);
        pugToken.transfer(bob, 100 ether);
        assertEq(pugToken.balanceOf(bob), 100 ether);
    }

    function testMintPug() public {
        vm.prank(msg.sender);
        pugToken.mint(100 ether);
        assertEq(pugToken.balanceOf(msg.sender), INITIAL_SUPPLY + (100 ether));
    }

    function testBurnPug() public {
        vm.prank(msg.sender);
        pugToken.burn(100 ether);
        assertEq(pugToken.balanceOf(msg.sender), INITIAL_SUPPLY - (100 ether));
    }

    function testApprove() public {
        vm.prank(msg.sender);
        pugToken.transfer(bob, 100 ether);

        vm.prank(bob);
        pugToken.approve(alice, 10 ether);
        assertEq(pugToken.allowance(bob, alice), 10 ether);

        vm.prank(alice);
        pugToken.transferFrom(bob, harry, 5 ether);
        assertEq(pugToken.balanceOf(bob), 95 ether);
    }
}
