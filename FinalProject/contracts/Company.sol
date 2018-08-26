pragma solidity ^0.4.24;

// ----------------------------------------------------------------------------
// ConsenSys Academy’s 2018 Developer Program Final Project
//
// https://github.com/conwise18/Consensys-Final-Project
//
// BokkyPooBah / Bok Consulting Pty Ltd / The MIT Licence.
// GitHub: https://github.com/bokkypoobah/ClubEth
// 
// Enjoy! (c) Connor Wiseman 
// ----------------------------------------------------------------------------

// Library declaration
library Member {
    
    // Data storage
    struct Members {
        bool exists;
        uint index;
        string name;
    }

    struct Account {
        address id;
        uint index;
        string company;
        string country;
        string industry;
        bool active;
    }
    
    struct Data {
        bool initialised;
        mapping (address => Members) entries;
        mapping (address => Account) companyAccounts;
        address[] members;
        address[] companies;
    }
    
    // Events
    event MemberAdded(address indexed memberAddress, string name, uint totalAfter);
    event CompanyAdded(address indexed settlerAddress, string name, uint totalAfter);
    
    // Function checks membership of a given address
    function isMember(Data storage self, address memberAddress) internal view returns (bool) {
        return self.entries[memberAddress].exists;
    }
    
    // Function checks if a company address is active
    function isCompany(Data storage self, address _companyAddress) internal view returns (bool) {
        return self.companyAccounts[_companyAddress].active;
    }
    
    // Function create a new member 
    function add(Data storage self, address memberAddress, string memberName) internal {
        require(!self.entries[memberAddress].exists);
        self.members.push(memberAddress);
        self.entries[memberAddress] = Members(true, self.members.length - 1, memberName);
        emit MemberAdded(memberAddress, memberName, self.members.length);
    }
    
    // Function creates a new company 
    function company(Data storage self, address _companyAddress, string _companyName, string _companyResidence, string _industry) internal {
        require (!self.entries[_companyAddress].exists);
        self.companies.push(_companyAddress);
        self.companyAccounts[_companyAddress] = Account(_companyAddress, self.companies.length - 1, _companyName, _companyResidence, _industry, true);
        emit CompanyAdded(_companyAddress, _companyName, self.companies.length);
    }
    
}

// Import statement for contract beneath 
import "./SupplyAccessControl.sol";

// Contract declaration
contract Company is SupplyAccessControl {
    
    // Using the above library for function calls
    using Member for Member.Data;
    
    // Keyword "members" shall be called to access library data
    Member.Data members;
    
    // Modifiers
    modifier onlyMember {
        require(members.isMember(msg.sender));
        _;
    }
    
    modifier onlyCompany {
        require(members.isCompany(msg.sender));
        _;
    }
    
    // Function adds new member 
    // Dev - library function "add" is run when function is called
    function addMember(address _memberAddress, string _memberName) public {
        members.add(_memberAddress, _memberName);
    }
    
    // Function adds new company
    // Dev - library function "company" is run when function is called
    function addCompany(address _companyAddress, string _settlerName, string _companyResidence, string _industry) public onlyCLevel() {
        members.company(_companyAddress, _settlerName, _companyResidence, _industry);
    }
}
