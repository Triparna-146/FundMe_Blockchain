// Get funds from users
// withdraw funds
// set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUSD = 5 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable  {
        //Allow users to send money
        // Have a minimum limit $5
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
    
}