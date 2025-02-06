// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallbackExample {
    uint256 public result;

    receive() external payable { 
        result = 1;
    }

    fallback() external payable { 
        result = 2;
    }

    // function withdraw (address add) public  {

    //     //call
    //     (bool callSuccess, ) = payable(add).call{value: address(this).balance}("");
    //     require(callSuccess, "Call Failed");
    // }
}