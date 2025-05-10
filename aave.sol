// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "add overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "sub underflow");
        return a - b;
    }
}

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract Aave {
    using SafeMath for uint256;

    struct UserInfo {
        address referrer;
        uint256 investAmount;       
        uint256 interestAmount;      
        uint256 rewardAmount;       
        uint256 lastExtractTime;
        uint256 teamCount;
        uint256 teamInvestAmount;
        uint256 level;
        bool isLevelLock;
        bool isChild;
        bool isJoin;
        bool isBlack;
    }


    bool public isStop = false;
    IERC20 public usdtToken;
    mapping(address => UserInfo) public users;
    event Withdraw(address indexed user, uint256 principal, uint256 interestReward);

function deposit(uint256 amount) external{}

    function withdraw(uint256 amount) external {

    }
    function withdrawInterestAndReward() external  {
        UserInfo storage u = users[msg.sender];
        uint256 interest = u.interestAmount;
        uint256 reward = u.rewardAmount;
        uint256 total = interest.add(reward);

        require(total > 0, "no amount");

        u.interestAmount = 0;
        u.rewardAmount = 0;
        u.lastExtractTime = block.timestamp;

        require(usdtToken.transfer(msg.sender, total), "transfer failed");

        emit Withdraw(msg.sender, 0, total);
    }


}  
