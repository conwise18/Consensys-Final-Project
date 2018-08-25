pragma solidity ^0.4.19;

library Member {
    
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
        mapping (address => Account) companies;
        address[] members;
        address[] company;
    }
    
    event MemberAdded(address indexed memberAddress, string name, uint totalAfter);
    event CompanyAdded(address indexed settlerAddress, string name, uint totalAfter);
    
    function isMember(Data storage self, address memberAddress) internal view returns (bool) {
        return self.entries[memberAddress].exists;
    }
    
    function isCompany(Data storage self, address _companyAddress) internal view returns (bool) {
        return self.companies[_companyAddress].active;
    }
    
    function add(Data storage self, address memberAddress, string memberName) internal {
        require(!self.entries[memberAddress].exists);
        self.members.push(memberAddress);
        self.entries[memberAddress] = Members(true, self.members.length - 1, memberName);
        emit MemberAdded(memberAddress, memberName, self.members.length);
    }
    
    function Company(Data storage self, address _companyAddress, string _companyName, string _companyResidence, string _industry) internal {
        require (!self.entries[_companyAddress].exists);
        self.company.push(_companyAddress);
        self.companies[_companyAddress] = Account(_companyAddress, self.company.length - 1, _companyName, _companyResidence, _industry, true);
        emit CompanyAdded(_companyAddress, _companyName, self.company.length);
    }
    
}

import "./SupplyAccessControl.sol";

contract Company is SupplyAccessControl {
    
    using Member for Member.Data;
    
    Member.Data members;
    
    modifier onlyMember {
        require(members.isMember(msg.sender));
        _;
    }
    
    modifier onlyCompany {
        require(members.isCompany(msg.sender));
        _;
    }
    
    function addMember(address _memberAddress, string _memberName) public {
        members.add(_memberAddress, _memberName);
    }
    
    function addCompany(address _companyAddress, string _settlerName, string _companyResidence, string _industry) public onlyCLevel() {
        members.Company(_companyAddress, _settlerName, _companyResidence, _industry);
    }
}