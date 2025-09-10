// scripts/deploy.js
import hre from "hardhat";

async function main() {
  const Traceability = await hre.ethers.getContractFactory("AyurvedicTraceability");
  const traceability = await Traceability.deploy();
  await traceability.waitForDeployment();

  console.log(`AyurvedicTraceability deployed to: ${traceability.target}`);
}

main().catch((error) => {
  console.error("Deployment failed:", error);
  process.exitCode = 1;
});
