//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract SimpleAuction{
    //拍卖的参数
    address public beneficiary;
    // 时间戳
    uint public auctionEnd;

    //拍卖的当前状态
    address public highestBidder;
    uint public highestBid;

    //可以取回之前的出价
    mapping(address => uint) pendingReturns;

    //拍卖结束后设为true，将禁止所有的变更

    //变更出发的事件
    event HighestBidIncreased(address bidder,uint amount);
    event AuctionEnded(address winner,uint amount);

    //以收益者地址 `_benficiary`的名义，
    //创建一个简单的拍卖，拍卖时间为`_biddingTime`秒。
    constructor(uint _biddingTime ,address _beneficiary){
        beneficiary = _beneficiary;
        auctionEnd = block.timestamp +_biddingTime;
    }

    //对拍卖进行出价，具体的出价随交易一起发送。
    // 如果没有在拍卖中胜出，则返还出价。
    function bid()public payable{
        //参数不是必要的，因为所有的信息已经包含在了交易中
        //对于能接收以太币的函数，关键字payable是必须的

        //如果拍卖以结束，撤销函数的调用
        require(block.timestamp <= auctionEnd);

        //如果出价不够高，返还你的钱
        require(msg.value > highestBid);
        if (highestBid != 0){
            //返还出价是，简单地直接调用highestBidder.send(highestBid)函数，
            //是有安全风险的，因为它有可能执行一个非信任合约
            //更为安全的做法是让接收方字节提取金钱
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }


}