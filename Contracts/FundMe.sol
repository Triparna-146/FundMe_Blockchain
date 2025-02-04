// Get funds from users
// withdraw funds
// set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUSD = 5 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable  {
        //Allow users to send money
        // Have a minimum limit $5
        require(getConversionRate(msg.value) >= minimumUSD, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice () public view returns (uint256){
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //Price of ETH in USD
        return uint256(price * 1e10);
    }

    function getConversionRate (uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
    
}