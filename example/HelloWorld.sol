//声明版本号
pragma solidity ^0.4.16;

// 合约 有点类似于java中的class
contract HelloWorld{
    //合约属性变量
    string myName = "HelloWorld";
    //合约中方法 注意语法顺序 其中此处view 代表方法只读 不会消耗gas(燃料)
    function getName() public view returns(string){
        return myName;
    }
    //可以修改属性变量的值 消耗gas
    function changeName(string _newName)public {
        myName = _newName;
    }
    //pure : 不能读取也不能改变状态变量
    function pureName(string _name) public pure returns (string){
        return _name;
    }
    
}