// scripts/deploy.js
import hre from "hardhat";

async function main() {
  const Traceability = await hre.ethers.getContractFactory("AyurvedicTraceability");
  const traceability = await Traceability.deploy();

  // ✅ Ethers v5 way
  await traceability.deployed();

  console.log(`✅ AyurvedicTraceability deployed to: ${traceability.address}`);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
