

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../src/Vault.sol";


contract MockERC20 is ERC20{
    constructor() ERC20("MockERC20", "MOCK"){}

    function mint(address to, uint256 amount) external{
        _mint(to,amount);
    }
}


contract VaultTest is Test {
    Vault public vault;
    MockERC20 public mockERC20;
    address user1;
    address user2;

    function setUp() public {
        mockERC20 = new MockERC20();
        vault = new Vault(address(mockERC20));

        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        mockERC20.mint(user1, 1000);
        mockERC20.mint(user2, 1000);

    }

    function test_Deposit() public {
        console.log("user1 balance before deposit", mockERC20.balanceOf(user1));

        vm.startPrank(user1);
        mockERC20.approve(address(vault), 100);
        vault.deposit(100);
        vm.stopPrank();

        console.log("user1 balance after deposit", mockERC20.balanceOf(user1));
        console.log("user1 shares", vault.balanceOf(user1));
    }

    function test_Withdraw() public {
        console.log("=== TEST WITHDRAW ===");
        console.log("Saldo awal:", mockERC20.balanceOf(user1));

        // Step 1: Deposit dulu
        vm.startPrank(user1);
        mockERC20.approve(address(vault), 100);
        vault.deposit(100);
        vm.stopPrank();

        console.log("Setelah deposit 100 token:", mockERC20.balanceOf(user1));

        // Step 2: Withdraw sebagian
        vm.startPrank(user1);
        vault.withdraw(50);
        vm.stopPrank();

        console.log("Setelah withdraw 50 shares:", mockERC20.balanceOf(user1));

        // Assertions
        assertEq(mockERC20.balanceOf(user1), 950, "Saldo token harus 950");
        assertEq(vault.balanceOf(user1), 50, "Shares harus tersisa 50");
        assertEq(vault.totalSupply(), 50, "Total supply harus 50");
    }
}