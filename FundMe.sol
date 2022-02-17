// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

contract FundMe{
    //creating an array to keep track of all the addresses which sent us the funds(optional)
    address[] public _addresses;

    // creating a mapping of addresses and value
    mapping(address => uint256) public addressToAmountFunded;

    //creating a function to allow the payments to happen
    function fund() public payable{
        addressToAmountFunded[msg.sender] += msg.value;
        _addresses.push(msg.sender);
    }

    // creating a function to view the amount funded using the index of _addresses(optional)
    function getValue(uint256 _addressesIndex) public view returns(uint256){
        return addressToAmountFunded[_addresses[_addressesIndex]];
    }
}