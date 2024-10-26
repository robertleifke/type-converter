// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../TypeConverter.sol";

contract TypeConverterTest is Test {
    TypeConverter public converter;

    function setUp() public {
        converter = new TypeConverter();
    }

    function testAsciiToUint() public view {
        assertEq(converter.asciiToUint("420"), 420);
    }

     function testAsciiToUintTwo() public view {
        assertEq(converter.asciiToUint("711"), 711);
    }

    function testHexToUint() public view {
        assertEq(converter.hexToUint("7b"), 123);
    }
}