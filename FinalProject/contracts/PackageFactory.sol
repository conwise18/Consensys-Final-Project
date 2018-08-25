pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// ConsenSys Academy’s 2018 Developer Program Final Project
//
// https://github.com/conwise18/Consensys-Final-Project
//
// Enjoy! (c) Connor Wiseman / The MIT Licence.
// ----------------------------------------------------------------------------

import "./Company.sol";
import "./ERC721Token.sol";

// Contract declaration.
contract PackageFactory is Company, ERC721Token  {

    // State variables
	address public owner;
	uint public packageCount;
	
	// Numerical length of item id will be 10000000000000000000 
	uint idLength = 10 ** 18;
	
	// Data storage
	enum status {packaged, distributed, shelved}

	struct Package {
	    uint id;
	    uint packageNum;
		uint date;
		string name;
		string location;
		string contents;
		status Status;
		bool active;
	}

	Package[] private packages;

	mapping (uint => mapping(address => Package)) public packageOwner;
	
	// Events 
	event packageCreated(uint _id, uint _date, string _name, string _location, string _contents, uint index);
	event packageSigned(uint _id, uint newId, uint _tokenId, address _signer);

	// Constructor function sets owner as the contract creator and the number of current items to 0
	constructor () public {
		owner = msg.sender;
		packageCount = 0;
	}

    // Function allows for creation of a new package, this can only be called by an authorized organisation
    // params - id number, date of creation, item name, item location, contents if any
	function createPackage(uint _id, uint _date, string _name, string _location, string _contents) public onlyCompany() {
		uint Id = createId(_id);
		Package memory b = packageOwner[packageCount][msg.sender];
		packageOwner[packageCount][msg.sender] = Package({
		    id: Id,
			date: _date,
			packageNum: packageCount,
			name: _name,
			location: _location,
			contents: _contents,
			Status: status.packaged,
			active: true
			});
		_mint(msg.sender, Id);
		packageCount = packageCount + 1;
		packages.push(b);
		emit packageCreated(_id, _date, _name, _location, _contents, packages.length);
	}

    // Function signs package with signers address
    // param - item id, tokenId linked with item, address of person signing.
    function signPackage (uint _id, uint _tokenId, address _signer) public onlyCompany() returns (uint) {
	    uint256 newId = uint(keccak256(abi.encodePacked(_id, _tokenId, _signer)));
	    packageOwner[_id][msg.sender].id = newId % idLength;
	    emit packageSigned(_id, newId, _tokenId, _signer);
	    return packageOwner[newId][msg.sender].id;
	}
	
	// Function returns total length of packages
    function getPackages() public constant returns (uint) {
        return packages.length;
    }
    
    // Function returns the information of a specified package
    // param - the number of the package and the associated organisation 
    function getPackage(uint _packageNum, address _companyAddress) public constant returns(uint id, uint date, string name, string location, string contents) {
        return (packageOwner[_packageNum][_companyAddress].id,
                packageOwner[_packageNum][_companyAddress].date,
        	    packageOwner[_packageNum][_companyAddress].name, 
                packageOwner[_packageNum][_companyAddress].location, 
                packageOwner[_packageNum][_companyAddress].contents);
    }
	
	// Function creates the id when a new package is added
	// param - id given the to package
	function createId(uint256 _id) internal view returns (uint256) {
        uint256 id = uint(keccak256(abi.encodePacked(_id)));
        return id % idLength;
    }
    
}
