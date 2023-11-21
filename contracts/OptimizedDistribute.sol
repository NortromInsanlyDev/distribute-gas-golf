// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    address payable immutable contributor1;
    address payable immutable contributor2;
    address payable immutable contributor3;
    address payable immutable contributor4;
    address payable immutable contributor5;
    address payable immutable contributor6;

    uint256 immutable endTime;

    constructor(address[6] memory _contributors) payable {
        contributor1 = payable(_contributors[0]);
        contributor2 = payable(_contributors[1]);
        contributor3 = payable(_contributors[2]);
        contributor4 = payable(_contributors[3]);
        contributor5 = payable(_contributors[4]);
        contributor6 = payable(_contributors[5]);
        endTime = block.timestamp + 1 weeks;
    }

    function distribute() external {
        require(block.timestamp > endTime, "cannot distribute yet");

        uint256 amount = address(this).balance / 6;
        contributor1.send(amount);
        contributor2.send(amount);
        contributor3.send(amount);
        contributor4.send(amount);
        contributor5.send(amount);
        selfdestruct(contributor6);
    }
}
