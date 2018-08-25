# Avoiding common attacks and vunerabilities 

The smart contracts in FinalProject have been protected from bugs and attack vectors such as un-authorized access, integer underflow and overflow and re-entrancy. The aim was to mitigate these attack senarios through the projects scripts by using librarys such as SafeMath for integers, function modifiers and ownership to contracts. Simple but fine logic has also been used for the body of the functions. 

## Accessibility

 * The smart contracts given in the project file all have modifiers that only allow an address with certain permissions to call particular functions. This is so the application will be able to support the needs of organizational structure in real world senarios. The person who deploys the contracts will also be given certain rights that allow for maintainance or governance of the application once the contracts are deployed to the blockchain. 
 * Using libraries for internal functions also alleviates the pressure from hackers.
 
 ## Underflow and Overflow management
 
 * The Open Zeppelin SafeMaths library is being used throughout the structure of the projects smart contracts to tackle the potential of underflow and overflow of units and integers. The scripts are using the SafeMath library for numbers of 256bits that deal with identification codes, and account balances. 
 
 ## Function visibility 
 
 * Using internal/private functions where possible to keep function bodys simple and small, trying to keep code logic reuseable.
 
 *PLEASE NOTE: for test purposes "mint" and "burn" functions are public not internal. 
 
 
 
 
