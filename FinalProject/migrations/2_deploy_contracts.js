const AddressUtils = artifacts.require('AddressUtils');
const Company = artifacts.require('Company');
const ERC721 = artifacts.require('ERC721');
const ERC721Basic = artifacts.require('ERC721Basic');
const ERC721BasicToken = artifacts.require('ERC721BasicToken');
const ERC721Holder = artifacts.require('ERC721Holder');
const ERC721Receiver = artifacts.require('ERC721Receiver');
const ERC721Token = artifacts.require('ERC721Token');
const PackageFactory = artifacts.require('PackageFactory');
const SafeMath = artifacts.require('SafeMath');
const SupplyAccessControl = artifacts.require('SupplyAccessControl');
const ERC165 = artifacts.require('ERC165.sol');
const SupportsInterfaceWithLookup = artifacts.require('SupportsInterfaceWithLookup.sol');


module.exports = function(deployer) {
    deployer.deploy(PackageFactory);
};
