import "@nomicfoundation/hardhat-toolbox";
import fs from "fs";
import "hardhat-preprocessor";
import "@openzeppelin/hardhat-upgrades"
import "@nomicfoundation/hardhat-verify";
import dotenv from "dotenv";
dotenv.config();

function getRemappings() {
  return fs
      .readFileSync("remappings.txt", "utf8")
      .split("\n")
      .filter(Boolean) // remove empty lines
      .map((line) => line.trim().split("="));
}


//const config: HardhatUserConfig = {
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version:"0.8.12",
    settings:{
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    // hardhat: {
    //   chainId: 17000,
    //   forking: {
    //     enabled: true,
    //     url: process.env.HOLESKY_ARCHIVE_URL!,
    //     blockNumber: 1502050,
    //   },
    // },
    holesky: {
      url: process.env.HOLESKY_URL,
      accounts: [process.env.HOLESKY_ACCOUNT_0!],
    },
  },
  etherscan: {
    apiKey: {
      holesky: process.env.HOLESKY_EXPLORER_API!,
    },
  },
  preprocess: {
    eachLine: () => ({
      transform: (line: string) => {
        if (line.match(/^\s*import /i)) {
          for (const [from, to] of getRemappings()) {
            if (line.includes(from)) {
              line = line.replace(from, to);
              break;
            }
          }
        }
        return line;
      },
    }),
  },
  paths:{
    root: "src"
  }
};

//export default config;