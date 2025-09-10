const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  const AyurvedicTraceability = await hre.ethers.getContractFactory("AyurvedicTraceability");
  const traceability = await AyurvedicTraceability.deploy();

  await traceability.waitForDeployment();
  const address = await traceability.getAddress();

  console.log("✅ AyurvedicTraceability deployed to:", address);

  // Save contract info for frontend
  const contractData = {
    address,
    abi: require("../artifacts/contracts/AyurvedicTraceability.sol/AyurvedicTraceability.json").abi,
  };

  const filePath = path.join(__dirname, "../frontend/contractData.json");
  fs.writeFileSync(filePath, JSON.stringify(contractData, null, 2));

  console.log("📂 Contract data saved to:", filePath);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
