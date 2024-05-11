import hre from "hardhat";
import {upgrades} from "hardhat"

async function main() {
    const accounts = await hre.ethers.getSigners();
    const rockxEth = await hre.ethers.getContractFactory("RockXETH", accounts[0]);
    console.log("Deploying rockxEth...");
    const rockxEthDeploy = await upgrades.deployProxy(rockxEth,[],{unsafeAllow:["constructor"]});
    const rockxEthDeployed = await rockxEthDeploy.waitForDeployment();
    console.log(
        "rockxEth deployed to:%s, hash:%s",
        await rockxEthDeployed.getAddress(),
        rockxEthDeployed.deploymentTransaction()!.hash,
    );
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
