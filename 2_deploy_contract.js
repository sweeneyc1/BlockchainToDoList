var Lists = artifacts.require("./List.sol");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(Lists, [], {from: accounts[1], gas: 6700000});
}
