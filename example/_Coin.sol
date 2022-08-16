pragma solidity ^0.8.4;

contract Coin{

    // 创建了一个公共状态变量
    address public minter;
    // 映射类型将地址映射到无符号整数
    mapping(address => uint) public balances;

    //声明了一个事件 ， 以太坊可以在无需太多成本的情况下监听在区块链上发出的这些事件，监听器就会收到
    //from , to 和 amount 参数，这使得跟踪事务成为可能
    event Sent(address from,address to, uint amount);

    //这是构造函数，只有当合约创建时运行
    //构造函数永久存储创建人合约的人的地址
    //msg.sender 始终记录当前(外部)函数调用来自哪一个地址
    constructor(){
        minter = msg.sender;
    }

     //只有合约的创始人才能给自己加钱
    function mint(address receiver,uint amount)public{
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    function queryMinterBalance() public view returns (uint){
        return balances[msg.sender];
    }

    error InsufficientBalance(uint required, uint available);

    function send(address receiver,uint amount) public{
        if(amount > balances[msg.sender])
            revert InsufficientBalance({
                required:amount,
                available:balances[msg.sender]
            });
            // 创建人燃料减少
            balances[msg.sender] -= amount;
            // 
            balances[receiver] += amount;
            emit Sent(msg.sender,receiver,amount);
    }

}