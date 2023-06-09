// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StackContract.sol";
import "./mocks/MockERC20.sol";

contract StackContractTest is Test {
    StakeContract public stackContract;
    MockERC20 public mockERC20;

    function setUp() public {
        console2.log("StackContractTest setUp");
        stackContract = new StakeContract();
        mockERC20 = new MockERC20();
    }

    function testStack() public {
        uint256 amount = 10e18;
        mockERC20.approve(address(stackContract), amount);
        bool stackPassed = stackContract.stake(amount, address(mockERC20));
        assertTrue(stackPassed);
    }

}
