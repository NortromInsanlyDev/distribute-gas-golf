// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    address payable immutable contributor1;
    address payable immutable contributor2;
    address payable immutable contributor3;
    address payable immutable contributor4;

    uint256 immutable endTime;

    constructor(address[4] memory _contributors) payable {
        contributor1 = payable(_contributors[0]);
        contributor2 = payable(_contributors[1]);
        contributor3 = payable(_contributors[2]);
        contributor4 = payable(_contributors[3]);
        endTime = block.timestamp + 1 weeks;
    }

    function distribute() external {
        require(block.timestamp > endTime, "cannot distribute yet");

        uint256 amount = address(this).balance / 4;
        contributor1.send(amount);
        contributor2.send(amount);
        contributor3.send(amount);
        selfdestruct(contributor4);
    }
}
