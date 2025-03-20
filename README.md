# CoolLottery Smart Contract

## Overview
`CoolLottery` is a decentralized lottery smart contract built on Ethereum using Solidity. It allows players to join by sending a minimum of 0.01 ETH, and after a set duration, the organizer can pick a random winner who receives the entire prize pool.

## Features
- **Decentralized**: Runs entirely on the Ethereum blockchain.
- **Simple Participation**: Players join by sending ETH.
- **Random Winner Selection**: Uses a pseudo-random function to pick a winner.
- **Transparency**: All transactions and events are logged on-chain.

## Contract Details
- **Solidity Version**: `^0.8.0`
- **File Name**: `CoolLottery.sol`

## How It Works
1. **Deployment**: The organizer deploys the contract with a specified duration (e.g., 86400 seconds for 1 day).
2. **Joining**: Players call the `enter()` function with at least 0.01 ETH to participate.
3. **Ending**: After the duration ends, the organizer calls `pickWinner()` to select a winner.
4. **Prize**: The winner receives the full balance of the contract.

## Functions
- `enter()`: Allows players to join the lottery (payable, min 0.01 ETH).
- `pickWinner()`: Selects a random winner and sends the prize (restricted to the organizer).
- `getBalance()`: Returns the current contract balance.
- `getPlayers()`: Returns the list of participants.

## Events
- `NewPlayer(address player)`: Emitted when a new player joins.
- `WinnerSelected(address winner, uint amount)`: Emitted when a winner is chosen.

## Usage
1. Deploy the contract using a tool like Remix, Hardhat, or Truffle:
   - Pass the duration (in seconds) to the constructor.
   - Example: `CoolLottery(86400)` for a 1-day lottery.
2. Players send ETH to the `enter()` function during the active period.
3. After the lottery ends, the organizer calls `pickWinner()` to distribute the prize.

## Security Notes
- **Randomness**: The `random()` function is pseudo-random and based on block data. For production, consider using an oracle like Chainlink VRF for true randomness.
- **Reentrancy**: The contract uses simple transfers, but for high-stakes use, add reentrancy guards.
- **Testing**: Test thoroughly on a testnet (e.g., Sepolia) before deploying to mainnet.

## Requirements
- Ethereum wallet (e.g., MetaMask)
- Solidity compiler (`^0.8.0`)
- ETH for deployment and participation

## License
This project is licensed under the MIT License - see the SPDX identifier in the contract.

## Author
Built with ❤️ by [Your Name or Handle] on March 20, 2025.
