# TypeConverter

`TypeConverter` has two utility functions written in [Yul](https://docs.soliditylang.org/en/latest/yul.html) that convert string data types into integers. Specifically, it converts ASCII-encoded decimal strings and hexadecimal strings into uint256 integers. While this contract is pretty much useless on its own, it's was a fun way to learn Yul and I reckon someone will find a way to use it for some super niche string-to-integer parsing use case.

## Features

- ASCII to Integer Conversion (asciiToUint): Converts base-10 ASCII-encoded strings (e.g., "1234") to uint256 values. Only characters '0'–'9' are allowed; any other input will trigger an InvalidInput error.

- Hexadecimal to Integer Conversion (hexToUint): Converts hexadecimal-encoded strings (e.g., "1A3F") to uint256 values. Supports both uppercase ('A'–'F') and lowercase ('a'–'f') hex characters. Requires the input to have an even length to represent valid bytes. An InvalidInput error is triggered for empty, uneven, or invalid hex strings.

## Gas Report

| TypeConverter.sol:TypeConverter contract | | | | | |
|------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost | Deployment Size | | | | |
| 180753 | 622 | | | | |
| Function Name | min | avg | median | max | # calls |
| asciiToUint | 911 | 911 | 911 | 911 | 2 |
| hexToUint | 1055 | 1055 | 1055 | 1055 | 1 |
