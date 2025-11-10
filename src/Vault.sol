// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Import ERC20: untuk membuat token shares (VAULT token)
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
// Import IERC20: untuk berinteraksi dengan token yang di-deposit (assetToken)
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
// Import Ownable: untuk kontrol akses (hanya owner yang bisa distribute yield)
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title Vault
 * @notice Kontrak vault yang menerima deposit token ERC20 dan memberikan shares sebagai bukti kepemilikan
 * @dev Mirip dengan ERC4626 vault - user deposit token, dapat shares, dan bisa withdraw kapan saja
 */
contract Vault is ERC20, Ownable {
    // Address dari token yang bisa di-deposit ke vault ini (misal: USDC, DAI, dll)
    address public assetToken;

    // Custom error: lebih gas-efficient daripada require dengan string
    error AmountCannotBeZero();

    // Event yang di-emit ketika ada deposit (untuk tracking di blockchain)
    event Deposit(address indexed sender, uint256 amount, uint256 shares);
    // Event yang di-emit ketika ada withdraw
    event Withdraw(address indexed sender, uint256 amount, uint256 shares);


    constructor(address _assetToken) ERC20("Vault", "VAULT") Ownable(msg.sender) {
        assetToken = _assetToken;
    }

    function deposit(uint256 amount) external {
        //jika amount adalah 0, maka revert
        if(amount == 0) revert AmountCannotBeZero();

        //jika assetToken adalah 0, maka revert
        uint256 shares = 0;
        uint256 totalAssets = IERC20(assetToken).balanceOf(address(this));

        if(totalSupply() == 0){
            shares = amount;
        } else {
            shares = (amount * totalSupply()) / totalAssets;
            
        }

        //transfer amount dari msg.sender ke address(this)
        IERC20(assetToken).transferFrom(msg.sender, address(this), amount);
        //mint shares ke msg.sender
        _mint(msg.sender, shares);
        //emit event Deposit
        emit Deposit(msg.sender, amount, shares);
    }

    function withdraw(uint256 shares) external {
        uint256 totalAssets = IERC20(assetToken).balanceOf(address(this));
        uint256 amount = (shares * totalAssets) / totalSupply();

        _burn(msg.sender, shares);
        IERC20(assetToken).transfer(msg.sender, amount);

        emit Withdraw(msg.sender, amount, shares);
    }

    

    function distributeYield(uint256 amount) external onlyOwner {
       IERC20(assetToken).transferFrom(msg.sender,address(this), amount);
    }


}

// RUN