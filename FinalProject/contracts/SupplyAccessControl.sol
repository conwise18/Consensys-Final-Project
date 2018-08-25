pragma solidity ^0.4.23;

// ----------------------------------------------------------------------------
// ConsenSys Academy’s 2018 Developer Program Final Project
//
// https://github.com/conwise18/Consensys-Final-Project
//
// Enjoy! (c) Connor Wiseman / The MIT Licence.
// ----------------------------------------------------------------------------


// Contract declaration
contract SupplyAccessControl {
    
    // State variables
    address public CEO;
    address public CTO;
    address public COO;
    address public CFO;

    
    // Modifier functions
    modifier onlyCEO() {
        require (msg.sender == CEO);
        _;
    }
    
    modifier onlyCTO() {
        require (msg.sender == CTO);
        _;
    }
    
    modifier onlyCOO() {
        require (msg.sender == COO);
        _;
    }
    
    modifier onlyCFO() {
        require (msg.sender == CFO);
        _;
    }
    
    modifier onlyCLevel() {
        require (msg.sender == CEO ||
                 msg.sender == CTO ||
                 msg.sender == COO ||
                 msg.sender == CFO);
        _;
    }
    

    // Constructor function
    constructor () public {
        CEO = msg.sender;
    }
    
    // Function add new CTO
    function addCTO(address _newCTO) public onlyCLevel {
        require (_newCTO != address(0));
        CTO = _newCTO;
    }
    
    // Function add new COO
    function addCOO(address _newCOO) public {
        require (_newCOO != address(0));
        COO = _newCOO;
    }
    
    // Function add new CFO
    function addCFO(address _newCFO) public {
        require (_newCFO != address(0));
        CFO = _newCFO;
    }
    
    // Fallback function
    function () external payable {
        
    }
    
    // Function allows to withdraw contract funds
    function withdraw() public onlyCEO {
        CEO.transfer(address(this).balance);
    }
    
}
