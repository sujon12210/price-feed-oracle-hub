const hre = require("hardhat");

async function main() {
  // ETH/USD Chainlink Feed on Sepolia
  const SEPOLIA_ETH_USD = "0x694AA1769357215DE4FAC081bf1f309aDC325306";

  const OracleConsumer = await hre.ethers.getContractFactory("OracleConsumer");
  const consumer = await OracleConsumer.deploy(SEPOLIA_ETH_USD);

  await consumer.waitForDeployment();

  console.log("Oracle Consumer deployed to:", await consumer.getAddress());
  
  const price = await consumer.getLatestPrice();
  console.log("Current Price from Oracle:", price.toString());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
