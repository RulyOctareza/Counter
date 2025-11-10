// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/vault.sol";
import {BahlilToken} from "../src/Bahlil.sol";

contract VaultScript is Script {
    Vault public vault;
    BahlilToken public bahlilToken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bahlilToken = new BahlilToken();
        console.log("BahlilToken deployed at:", address(bahlilToken));

        vault = new Vault(address(bahlilToken));
        console.log("Vault deployed at:", address(vault));
        
        vm.stopBroadcast();
    }
}