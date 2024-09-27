// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Lock {
    uint public unlockTime;
    address payable public owner;
    event Withdrawal(uint amount, uint when);

    constructor() payable {
        owner = payable(msg.sender);
    }

    function setUnlockTime(uint _unlockTime) public {
        require(msg.sender == owner, "Only owner can set unlock time");
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );
        unlockTime = _unlockTime;
    }

    function withdraw() public {
        require(unlockTime != 0, "Unlock time not set");
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");
        emit Withdrawal(address(this).balance, block.timestamp);
        owner.transfer(address(this).balance);
    }

    // Added function for testing purposes
    function getBlockTimestamp() public view returns (uint) {
        return block.timestamp;
    }
}
