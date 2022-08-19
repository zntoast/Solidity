//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1; 

contract SimpleStorage{
    uint storedDara;

    function set(uint x)public{
        storedDara = x;
    }

    function get() public view returns(uint){
        return storedDara;
    }
}