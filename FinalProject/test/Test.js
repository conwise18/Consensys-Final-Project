const { assertRevert } = require('../helpers/assertRevert');
const { shouldBehaveLikeERC721BasicToken } = require('../helpers/shouldBehaveLikeERC721BasicToken');
const { shouldBehaveLikeMintAndBurnERC721Token } = require('../helpers/ERC721MintBurn.behavior');
const _ = require('lodash');

const BigNumber = web3.BigNumber;
const ERC721BasicToken = artifacts.require('ERC721BasicToken.sol');
const ERC721Token = artifacts.require('ERC721Token.sol');

require('chai')
  .use(require('chai-bignumber')(BigNumber))
  .should();

  contract('ERC721Token', function (accounts) {
  const name = 'ProgramToken';
  const symbol = 'CPT';
  const firstTokenId = 100;
  const secondTokenId = 200;
  const nonExistentTokenId = 999;
  const creator = accounts[0];
  const anyone = accounts[9];

  beforeEach(async function () {
    this.token = await ERC721Token.new({ from: creator });
  });
 
    shouldBehaveLikeMintAndBurnERC721Token(accounts);
    shouldBehaveLikeERC721BasicToken(accounts);
});    
