const Token = artifacts.require("token721");
const crowdSale721 = artifacts.require("crowdSale721");



module.exports = async function (deployer) {

  const maxSupply = 1000;
  await deployer.deploy(Token, "Token721", "TCS721", maxSupply);

  const token = await Token.deployed();

  // let { timestamp } = await web3.eth.getBlock("latest")
  // console.log("timestamp",timestamp)
  // await deployer.deploy(crowdSale721, timestamp, timestamp+300, 1, 1, 1, token.address,{gas:210000});

  // await crowdSale721.deployed();
};
