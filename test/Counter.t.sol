// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Counter.sol";
import "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CounterTest is Test {
    Counter public counter;
    address public alice;
    Helper public h;
    IERC20 public dai;

    event MyEvent(uint256 indexed a, uint256 indexed b, uint256 indexed c);

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);

        h = new Helper();

        alice = address(1);
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testCheatCode() public {
        // vm 用来控制 evm 状态
        console2.log("Cheat code activated!");
        emit log_address(address(1));
        console2.log("before: ", block.timestamp);
        vm.warp(1000);
        console2.log("after: ", block.timestamp);
        console2.log(address(this));

        vm.prank(alice); // 只影响一次
        address caller = h.whoCalled();
        console2.log(caller);

        address caller1 = h.whoCalled();
        console2.log(caller1);

        // vm.starPrank(alice);
        // // 区间内都会受影响...
        // vm.stopPrank();

        console2.log("before: ", alice.balance);
        vm.deal(alice, 1 ether); // 改变账户状态
        console2.log("after: ", alice.balance);

        // vm.envAddress("DAI"); // 从环境变量读取值
        string memory rpc = vm.envString("ETH_RPC_URL");
        uint256 mainnet = vm.createFork(rpc);
        vm.selectFork(mainnet);
        // 下面的命令都在 mainnet 网络上执行
        console2.log("before: ", dai.balanceOf(alice));
        deal(address(dai), alice, 1 ether);
        console2.log("after: ", dai.balanceOf(alice));

        string memory message = "abc";
        bytes32 hash = keccak256(abi.encodePacked(message));
        console2.logBytes32(hash);

        string[] memory cmd = new string[](3);
        cmd[0] = "cast";
        cmd[1] = "keccak";
        cmd[2] = message;
        bytes memory result = vm.ffi(cmd);
        bytes32 hash1 = abi.decode(result, (bytes32));
        assertEq(hash, hash1);
    }

    // 测试事件
    function testEmit() public {
        // bool checkTopic1, bool checkTopic2, bool checkTopic3, bytes memory data
        // 代表需要判断事件的哪些参数，true 代表需要判断，false 代表不需要判断
        vm.expectEmit(true, false, false, true);
        emit MyEvent(1, 0, 3);
        h.emitEvent();
    }

    // 测试错误
    function testRevert() public {
        vm.expectRevert(
            abi.encodeWithSelector(Helper.CustomError.selector, "Error message")
        );
        h.revertFail();
    }
}

contract Helper {
    error CustomError(string message);
    event MyEvent(uint256 indexed a, uint256 indexed b, uint256 indexed c);

    function whoCalled() public returns (address) {
        return msg.sender;
    }

    function emitEvent() public {
        emit MyEvent(1, 2, 3);
    }

    function revertFail() public {
        revert CustomError("Error message");
    }
}
