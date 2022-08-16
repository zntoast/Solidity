pragma solidity ^0.4.16;

contract Math{

    //加
    function add(uint a,uint b)public pure returns(uint){
        return a+b;
    }

    //减
    function minus(uint a,uint b)public pure returns(uint){
        return a-b;
    }

    //乘
    function multiply(uint a,uint b)public pure returns(uint){
        return a*b;
    }
    //除
    function divide(uint a,uint b)public pure returns(uint){
        return a/b;
    }
    //取余
    function mod(uint a,uint b)public pure returns(uint){
        return a%b;
    }
    //运算
    function square(uint a,uint b)public pure returns(uint){
        return a**b;
    }

}