// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title OracleConsumer
 * @dev High-quality implementation of a Chainlink Price Feed consumer.
 */
contract OracleConsumer is Ownable {
    AggregatorV3Interface internal dataFeed;
    
    // Max age of a price update before it's considered stale (e.g., 3600 seconds)
    uint256 public constant STALE_PRICE_THRESHOLD = 3600;

    constructor(address _feedAddress) Ownable(msg.sender) {
        dataFeed = AggregatorV3Interface(_feedAddress);
    }

    /**
     * @dev Returns the latest price and validates data integrity.
     */
    function getLatestPrice() public view returns (int) {
        (
            uint80 roundId,
            int price,
            uint startedAt,
            uint updatedAt,
            uint80 answeredInRound
        ) = dataFeed.latestRoundData();

        require(price > 0, "Negative/Zero price from Oracle");
        require(updatedAt != 0, "Incomplete round");
        require(answeredInRound >= roundId, "Stale price round");
        require(block.timestamp - updatedAt <= STALE_PRICE_THRESHOLD, "Price data is too old");

        return price;
    }

    function updateFeedAddress(address _newFeed) external onlyOwner {
        dataFeed = AggregatorV3Interface(_newFeed);
    }
}
