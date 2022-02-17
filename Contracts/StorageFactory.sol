// SPDX-License-Identifier: MIT

// pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage{// this will make StorageFactory to inherit all the functions and the variables of SimpleStorage alaong with keeping its own function and variables intact.
//------------------------------------------------------------------------------------
    // to view the SimpleStorage contract created via StorageFactory
    SimpleStorage[] public _simpleStorageArray;
//------------------------------------------------------------------------------------
    function createSimpleStorage() public{
        //note by this you can deploy new SimpleStorage contracts but you cannot view them
        SimpleStorage _simpleStorage = new SimpleStorage();
        // to view the SimpleStorage contract created via StorageFactory
        _simpleStorageArray.push(_simpleStorage);
    }
//------------------------------------------------------------------------------------
    // creating a function to add the variables of the imported contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        // two things are needed first Address and the second ABI(Application Binary Interface)
        SimpleStorage simpleStorage = SimpleStorage(address(_simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber);
    }
//------------------------------------------------------------------------------------
    // creating a function to add the variables of the imported contract
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        // two things are needed first Address and the second ABI(Application Binary Interface)
        SimpleStorage simpleStorage = SimpleStorage(address(_simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.retrive();
    }
}