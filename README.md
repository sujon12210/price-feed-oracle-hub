# Price Feed Oracle Hub

A professional-grade repository for integrating decentralized oracles into DeFi protocols. This project provides a standardized interface for fetching real-time asset prices while implementing essential security checks like heartbeat validation and staleness detection.

## Key Features
* **Multi-Oracle Support:** Ready-to-use templates for Chainlink and Pyth.
* **Security Guardrails:** Checks for "Round ID" consistency and timestamp staleness to prevent arbitrage from outdated data.
* **Gas Efficiency:** Minimalist wrapper contracts designed for low-overhead calls.
* **Flat Structure:** Single-directory layout for easy copy-pasting into existing projects.

## Implementation Details
1. **Chainlink:** Uses `AggregatorV3Interface` to fetch $USD$ denominated prices.
2. **Pyth:** Demonstrates how to handle pull-based oracle updates.

## Setup
1. `npm install`
2. Update the contract addresses in `OracleConsumer.sol` for your specific network.
3. Deploy and call `getLatestPrice()`.
