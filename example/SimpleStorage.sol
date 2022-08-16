pragma solidity >=0.4.16 <0.9.0;

contract SimpleStorage{
    uint storedDara;

    function set(uint x)public{
        storedDara = x;
    }

    function get() public view returns(uint){
        return storedDara;
    }
}