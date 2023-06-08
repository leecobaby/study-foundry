// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Counter.sol";

contract CounterScript is Script {
    function setUp() public {
        console2.log("CounterScript setUp");
    }

    function run() public {
        // vm.broadcast();
        console2.log("CounterScript run");
        // 开始记录脚本中合约的调用和创建
        vm.startBroadcast();
        //生成合约对象
        Counter c = new Counter();
        // 结束记录
        vm.stopBroadcast();
    }

    function someFunction(uint256 x) public {
        console2.log("CounterScript someFuntion");
        console2.log(x);
    }

    function someFunction2(string calldata x) public {
        console2.log("CounterScript someFuntion2");
        console2.log(x);
    }

    function someFunction3(bytes calldata x) public {
        console2.log("CounterScript someFuntion3");
        console2.log(string(x));
    }
}
