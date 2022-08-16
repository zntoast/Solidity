//SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract BoolTest{

    bool a = false;
    int c = 100;
    int d = 200;
    function judge() public view returns(bool){
        return c==d;
    }    
    function getBoolDefault() public view returns(bool){
        return !a;
    }
}