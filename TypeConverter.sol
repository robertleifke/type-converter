// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TypeConverter {
    error InvalidInput();

    /* ///////////////////////////////////////////////////////////////
     * Converts an ASCII-encoded base-10 string to an integer.
     * Expects a string input with characters '0'-'9'.
     */ ///////////////////////////////////////////////////////////////
    function asciiToUint(string calldata str) public pure returns (uint256 result) {
        assembly {
            let len := str.length
            let data := str.offset // offset of str in calldata

            if iszero(len) { revert(0, 0) }

            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let char := byte(0, calldataload(add(data, i)))

                // character is between ASCII '0' and '9'
                if or(lt(char, 0x30), gt(char, 0x39)) {
                    mstore(0, 0x4ca88867) 
                    revert(0, 4)
                }

                result := add(mul(result, 10), sub(char, 0x30))
            }
        }
    }

    /* ///////////////////////////////////////////////////////////////
     * Converts a hexadecimal string to an integer.
     * Expects a string input with characters '0'-'9' and 'a'-'f' or 'A'-'F'.
     */ ///////////////////////////////////////////////////////////////
    function hexToUint(string calldata hexStr) public pure returns (uint256 result) {
        assembly {
            let len := hexStr.length
            let data := hexStr.offset

            if or(iszero(len), mod(len, 2)) {
                mstore(0, 0x4ca88867) // 
                revert(0, 4)
            }

            for { let i := 0 } lt(i, len) { i := add(i, 2) } {
                let char1 := byte(0, calldataload(add(data, i)))
                let char2 := byte(0, calldataload(add(data, add(i, 1))))

                let value1 := processHexChar(char1)
                let value2 := processHexChar(char2)

                // Shift result 8 bits left and add the two nibbles
                result := or(shl(8, result), or(shl(4, value1), value2))
            }

            function processHexChar(char) -> value {
                // Handle numbers ('0' - '9')
                if and(gt(char, 0x2f), lt(char, 0x3a)) { value := sub(char, 0x30) }
                // Handle lowercase ('a' - 'f')
                if and(gt(char, 0x60), lt(char, 0x67)) { value := add(sub(char, 0x61), 10) }
                // Handle uppercase ('A' - 'F')
                if and(gt(char, 0x40), lt(char, 0x47)) { value := add(sub(char, 0x41), 10) }
                
                if and(iszero(value), iszero(eq(char, 0x30))) {
                    mstore(0, 0x4ca88867) 
                    revert(0, 4)
                }
            }
        }
    }
}
