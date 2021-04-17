const betPool = artifacts.require('Betpool');

module.exports = async function(deployer) {
    await deployer.deploy(betPool);
};