// Get funds from users
// withdraw funds
// set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 1 * 1e18;
  

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable  {
        //Allow users to send money
        // Have a minimum limit $5
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }
    

    function withdraw () public onlyOwner {
        
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        //Reseting the array    
        funders = new address[](0);

        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner () {
        //require(msg.sender == i_owner, "Sender is not Owner");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }
    
    receive() external payable { 
        fund();
    }
    
    fallback() external payable { 
        fund();
    }
}