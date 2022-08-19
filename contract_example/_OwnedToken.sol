//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

        //token拥有者
contract OwnedToken{
    //TokenCreator是在下面定义的合约类型
    //若它本身不用于创建新的合约的话，它就是一个引用
    TokenCreator public creator;
    address public owner;
    string public name;
    // 这个是记载创建者和赋值名称的构造函数
    constructor(string memory _name) {
        owner = msg.sender;
        creator = TokenCreator(msg.sender);
        name = _name;
    }
    
    //修改名字
    function changeName(string memory newName) public{
        //只有是创造者才能修改
        if(msg.sender == owner) name = newName;
    }

    //获取访问合约的地址
    function getMsgAddress() public view returns (address){
        return msg.sender;
    }


    //交易
    function transfer(address newOwner) public{
        if(msg.sender != owner) return;
        // if(creator.isTokenTransferOk(newOwner))
        owner = newOwner;
    }
}
        //token 创造者
contract TokenCreator{

    //创建token
    function createToken(string memory name) public
    returns (OwnedToken TokenAddress)
    {
        return new OwnedToken(name); 
    } 

    //修改名字
    function changeName(OwnedToken tokenAddress,string memory name) public{
        tokenAddress.changeName(name);
    }

    //判断交易是否OK
    function isTokenTransferOk( address newOwner)public view returns(bool ok){
        address tokenAddress = msg.sender;
       return newOwner == tokenAddress;
    }
}