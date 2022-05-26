const { web3 } = require("@openzeppelin/test-environment");

const Token = artifacts.require("token721");
const crowdSale721 = artifacts.require("crowdSale721");



module.exports = async function (deployer) {
    const token = await Token.deployed();


let { timestamp } = await web3.eth.getBlock("latest")
  console.log("timestamp",timestamp)
  // console.log("timestamp, timestamp+300,1, 1, 1,token.address" , timestamp, timestamp+300,1, 1, 1,token.address)
  await deployer.deploy(crowdSale721, timestamp +180, timestamp+300,web3.utils.toWei("1"), 1, 1,token.address);

  const sale = await crowdSale721.deployed();
  // let saleOwner = sale.owner();
  // saleOwner = token.owner()
};
