pragma solidity ^0.4.24;

import "./Company.sol";
import "./ERC721Token.sol";

contract PackageFactory is Company, ERC721Token  {


	address public owner;
	uint public packageCount;
	
	uint idLength = 10 ** 18;
	
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
	
	event packageCreated(uint _id, uint _date, string _name, string _location, string _contents, uint index);
	event packageSigned(uint _id, uint newId, uint _tokenId, address _signer);

	constructor () public {
		owner = msg.sender;
		packageCount = 0;
	}
	
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

    function signPackage (uint _id, uint _tokenId, address _signer) public onlyCompany() returns (uint) {
	    uint256 newId = uint(keccak256(abi.encodePacked(_id, _tokenId, _signer)));
	    packageOwner[_id][msg.sender].id = newId % idLength;
	    emit packageSigned(_id, newId, _tokenId, _signer);
	    return packageOwner[newId][msg.sender].id;
	}
	
    function getPackages() public constant returns (uint) {
        return packages.length;
    }
    
    function getPackage(uint _packageNum, address _companyAddress) public constant returns(uint id, uint date, string name, string location, string contents) {
        return (packageOwner[_packageNum][_companyAddress].id,
                packageOwner[_packageNum][_companyAddress].date,
        	packageOwner[_packageNum][_companyAddress].name, 
                packageOwner[_packageNum][_companyAddress].location, 
                packageOwner[_packageNum][_companyAddress].contents);
    }
	
	function createId(uint256 _id) internal view returns (uint256) {
        uint256 id = uint(keccak256(abi.encodePacked(_id)));
        return id % idLength;
    }
    
    
}
