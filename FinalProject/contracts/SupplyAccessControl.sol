pragma solidity ^0.4.23;

contract SupplyAccessControl {
    
    address public CEO;
    address public CTO;
    address public COO;
    address public CFO;
    
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
    
    constructor () public {
        CEO = msg.sender;
    }
    
    function addCTO(address _newCTO) public {
        require (_newCTO != address(0));
        CTO = _newCTO;
    }
    
    function addCOO(address _newCOO) public {
        require (_newCOO != address(0));
        COO = _newCOO;
    }
    
    function addCFO(address _newCFO) public {
        require (_newCFO != address(0));
        CFO = _newCFO;
    }
    
    function () external payable {
        
    }
    
    function withdraw() public onlyCEO {
        CEO.transfer(address(this).balance);
    }
    
}