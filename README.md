<p align="center">
  <img src="assets/preview/hero.png" alt="Counter — ilustrasi proyek smart contract" width="100%">
</p>

<h1 align="center">Counter — Foundry Playground</h1>

<p align="center">
  <b>Latihan smart contract: token ERC-20 dan vault berbasis share.</b><br>
  Foundry · OpenZeppelin · Solidity
</p>

<p align="center">
  <img alt="Solidity" src="https://img.shields.io/badge/Solidity-0.8-363636?logo=solidity&logoColor=white">
  <img alt="Foundry" src="https://img.shields.io/badge/Toolchain-Foundry-000000">
  <img alt="OpenZeppelin" src="https://img.shields.io/badge/Library-OpenZeppelin-4E5EE4">
</p>

---

## ✨ Preview

<p align="center">
  <img src="assets/preview/hero.png" alt="Ilustrasi proyek smart contract" width="90%">
</p>

> **Catatan:** gambar di atas adalah *ilustrasi konsep*, bukan screenshot asli.

---

## 📖 Tentang

Proyek Foundry untuk latihan menulis, menguji, dan mendeploy smart contract. Meski namanya
"Counter", isi repo ini berkembang menjadi dua kontrak: **BahlilToken** (ERC-20 dengan
mint/burn) dan **Vault** (vault berbasis share dengan deposit, withdraw, dan distribusi yield).

---

## 📜 Kontrak

| Kontrak | Ringkasan |
|---|---|
| `BahlilToken` | ERC-20 + `Ownable`, fungsi `mint` dan `burn` |
| `Vault` | ERC-20 share + `Ownable`, `deposit`, `withdraw`, `distributeYield` (owner) |

---

## 🛠️ Tech Stack

| Area | Pilihan |
|---|---|
| Bahasa | Solidity |
| Toolchain | Foundry (Forge, Cast, Anvil) |
| Library | OpenZeppelin Contracts |

---

## 🚀 Perintah

```bash
forge build
forge test
forge fmt
forge snapshot
anvil
```

Deploy & verifikasi mengikuti `script/` yang tersedia di repo.

---

## 📁 Struktur

```text
├── src/
│   ├── Bahlil.sol     # BahlilToken
│   └── Vault.sol
├── test/
├── script/
└── foundry.toml
```

> ⚠️ Kode ini untuk latihan. Audit dulu sebelum dipakai di mainnet.
