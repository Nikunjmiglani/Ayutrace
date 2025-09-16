require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  networks: {
    hardhat: {}, // in-memory Hardhat network
    localhost: {
      url: "http://127.0.0.1:8545", // local RPC
    },
    // polygonAmoy: {
    //   url: process.env.ALCHEMY_API_URL,  
    //   accounts: [process.env.PRIVATE_KEY], 
    // },
  },
  mocha: {
    timeout: 20000,
  },
};
