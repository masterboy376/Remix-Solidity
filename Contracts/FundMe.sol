// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract FundMe{
    // creating a mapping of addresses and value
    mapping(address => uint256) public addressToAmountFunded;
    address[] public _funders;

    address public _owner;
    //owner will get all the money
    constructor() {
        // anyone who will deploy this contarct will be the owner
        _owner = msg.sender;
    }

    //creating a function to allow the fund payments to happen
    function fund() public payable{
        //minimum funding of 50$
        uint256 _minimumUSD = 50*10**18;
        require(getConversionRate(msg.value)>=_minimumUSD,"You need to spend more eth!");//if this is not true the it will revert the function
        addressToAmountFunded[msg.sender] += msg.value;
        _funders.push(msg.sender);
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer*10000000000);
    }

    //1000000000 wei
    function getConversionRate(uint256 _ethAmount) public view returns(uint256){
        uint256 _ethPrice = getPrice();
        uint256 _ethAmountInUSD = (_ethPrice * _ethAmount) / 1000000000000000000;
        return _ethAmountInUSD;
    }

    modifier onlyOwner{
        require(msg.sender == _owner);
        _;
    }

    //creating a function to withdraw the money
    function withdraw() payable onlyOwner public{
        // only give to contract owner
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 _fundersIndex = 0; _fundersIndex<_funders.length; _fundersIndex++){
            address _funder = _funders[_fundersIndex];
            addressToAmountFunded[_funder] = 0;
        }
        _funders = new address[](0);
    }

}