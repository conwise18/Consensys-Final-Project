# Smart contract design

The design behind the smart contracts of this project come from movement of logic in the state of contracts and function bodys. This logic needs to flow down the centre of the project to be utilized in the final deployment script that goes on the blockchain. Some design features like uncle contracts also exist in the project to maximize the functionality of the bytecode and ABI, making full use of the code from top to bottom. 

The application logic was built up from the items being made unique with the first set of smart contracts then the interactive logic of the decentralized application built on top. Accessing all of the necessary functions for the code to be functional as a real world application requires only the deployment of one smart contract. Achieving this was an objective from the start to also decrease the risk of vunerabilities within the d-app. 

The project code also includes a smart contract called "SupplyAccessControl" this smart contracts operates as a governance contract for any company that wishes to use this code. The contract allows for Ethereum addresses to be linked against a specific role such as C00, CF0 etc, these addresses can also be changed. 

Events are also used throughout the landscape of the smart contracts, events are being called whenever a important peice of data is being changed on the blockchain. And when new data is being added to the contract, using events helps the system design of the application due to the timestamping on the blockchain being easily auditable and can improve workflow within a business. 

• Most of the logic being used in the application will come from a set of 3 main smart contracts that are ERC721Token.sol, Company.sol and PackageFactory.sol 

These 3 contracts will allow you to 

* upon deployment set a given name and symbol to items being tracked by the smart contract
* allow entitys or organizations to register with the decentalized application
* add fellow members of an organization to the register
* create packages on the blockchain that can be exchanged with others 
* sign the package or item at a interval of manufacturing, distribution or shelving 
        
