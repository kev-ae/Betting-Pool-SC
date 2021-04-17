const { isMainThread } = require('node:worker_threads');

const betPool = artifacts.require('Betpool');
require('chai').use(require('chai-as-promised')).should();

const ETHER_ADDRESS = '0x0000000000000000000000000000000000000000';
const EVM_REVERT = 'VM Exception while processing transaction: revert';

contract('Betpool', ([deployer, user]) => {
    let betpool;

    beforeEach(async () => {
        betpool = betPool.new('option1', 'option2');
        betpool.register('option1', {value: 10**16, from: user});
    })

    describe('testing storage...', () => {
        describe('success', () => {
            it('checking user amount', async () => {
                expect(await betpool.getAmount()).to.be.eq(10**16);
            })
        })
    })
})