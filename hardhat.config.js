require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  paths: {
    sources: "./contracts",
  },
  // exclude node_modules/contracts
  solidity: {
    compilers: [{ version: "0.8.20" }],
    settings: {
      // This ensures only your contracts are compiled
      // and ignores node_modules/...
    }
  },
  // Hardhat workaround for HH1006
  paths: {
    sources: "./contracts", 
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000,
  },
  // Add this 👇
  external: {
    contracts: [],
    deployments: {},
  },
};
