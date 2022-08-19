//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Ballot{

    // 这里声明了一个新的复合类型用于稍后的变量
    // 它用来表示一个选民
    struct Voter{
        uint weight;  //计票的权重
        bool voted;  // 若为真，代表该人已投票
        address delegate; // 被委托人
        uint  vote ; // 投票提案的索引
    }

    // 提案的类型
    struct Proposal{
        string name;    //简称
        uint voteCount ; //得票数
    }

    //主席
    address public chairperson;

    //这声明了一个状态变量，为每个可能的地址存储一个`Voter`
    mapping(address => Voter)public voters;
    
    // 一个`Proposal` 结构类型的动态数组
    Proposal[] public proposals;
    
    // 为`proposalNames` 中的每个提案，创建一个新的表决
    //初始化
    constructor(string[] memory proposalNames){
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        //创建提案
        for (uint i = 0; i< proposalNames.length;i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount : 0
            }));
        }
    }

    //授权`voter`对这个(投票)表决进行投票
    // 只有 chairperson 可以调用该函数
    function giveRightToVote(address voter) public {
        require( 
            //判断当前使用者是否是合约创建者
            (msg.sender == chairperson) &&
            //判断 voter 是否投票过
            !voters[voter].voted &&
            //判断权voter的权重是否为0
            (voters[voter].weight == 0)
        );
        //满足以上条件则继续向下执行
        voters[voter].weight = 1;
    }

    // 把你的投票委托给投票者 
    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        //判断是否已经投票
        require(!sender.voted);
        //委托给自己是不允许的
        require(to != msg.sender);
        //传递给委托人的委托人
        while(voters[to].delegate != address(0)){
            to = voters[to].delegate;
            //不允许闭环委托
            require(to != msg.sender);
        }
        //相当于自己已经投了,实际已经转手，表示不能再投
        sender.voted =true;
        //投票转让
        sender.delegate =to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted){
            //若被委托者已经透过票了，直接增加得票数
            proposals[delegate_.vote].voteCount += sender.weight;
        }else{
            // 若被委托者还没投票，增加委托者的权重
            delegate_.weight += sender.weight;
        }
    }

    // 把你的票(包括委托给你的票)
    // 投给提案 proposals[propposal].name
    // 一个选民只能投一次票,投了之后其它的提案也不能投了
    function vote(uint proposal) public{
        Voter storage sender = voters[msg.sender];
        //如果没透过
        //字符串里不能使用中文说明
        require(!sender.voted,"Have voted");
        sender.voted = true;
        sender.vote = proposal;
        //如果 proposal 超过了数组的范围，则会自动抛出异常，并恢复所有的改动
        proposals[proposal].voteCount += sender.weight;
    }

    // 结合之前所有的投票，计算出最终胜出的提案,得出胜利的票数
    function winningProposal()public view returns (uint winningProposal_){
        uint winningVoteCount = 0;
        for(uint p = 0;p < proposals.length;p++){
            if(proposals[p].voteCount > winningVoteCount){
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    //调用 winningProposal函数以获取提案数组中获胜者的索引,并以此返回获胜者的名称
    function winnerName()public view returns(string memory winnerName_){
        winnerName_ = proposals[winningProposal()].name;
    }
}
