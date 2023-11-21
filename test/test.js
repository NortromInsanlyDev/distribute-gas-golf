const { use } = require('chai');
const { ethers } = require('hardhat');
const helpers = require('@nomicfoundation/hardhat-network-helpers');

use(require('chai-as-promised'));

const EIGHT_DAYS = 60 * 60 * 24 * 8;

describe('Distribute', async function () {
    let original;
    let optimized;
    let owner;
    let acct1;
    let acct2;
    let acct3;
    let acct4;
    let acct5;
    let acct6;

    beforeEach(async () => {
        [owner, acct1, acct2, acct3, acct4, acct5, acct6] = await ethers.getSigners();
        const Distribute = await ethers.getContractFactory(
            'Distribute'
        );
        original = await Distribute.deploy(
            [acct1.address, acct2.address, acct3.address, acct4.address, acct5.address, acct6.address],
            { value: ethers.utils.parseEther("1.5") }
        );

        await original.deployed();
        const OptimizedDistribute = await ethers.getContractFactory(
            'OptimizedDistribute'
        );
        optimized = await OptimizedDistribute.deploy(
            [acct1.address, acct2.address, acct3.address, acct4.address, acct5.address, acct6.address],
            { value: ethers.utils.parseEther("1.5") }
        );

        await optimized.deployed();
    });

    it('Compare gas usage between the original one and optimized version', async function () {
        await helpers.time.increase(EIGHT_DAYS);
        await helpers.setBalance(
            original.address,
            ethers.utils.parseEther('1.5')
        );
        await helpers.setBalance(
            optimized.address,
            ethers.utils.parseEther('1.5')
        );
    
        {
            const gasEstimate = await original.estimateGas.distribute();
            console.log(`original contract: ${gasEstimate}`);
        }
        
        {
            const gasEstimate = await optimized.estimateGas.distribute();
            console.log(`optimized contract: ${gasEstimate}`);
        }
    });
});
