// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract CounterScript is Script {
    function setUp() public {
        console2.log("CounterScript setUp");
    }

    function run() public {
        vm.broadcast();
        console2.log("CounterScript run");
    }

    function someFunction(uint256 x) public {
        console2.log("CounterScript someFuntion");
        console2.log(x);
    }

    function someFunction2(string calldata x) public {
        console2.log("CounterScript someFuntion2");
        console2.log(x);
    }

    function someFunction3(bytes32 x) public {
        console2.log("CounterScript someFuntion3");
        bytes memory y = 'hello';
        console2.log(string(y));
    }
}
