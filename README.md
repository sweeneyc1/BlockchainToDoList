# Blockchain To-do List

# Introduction
When an event is published on a blockchain it is immutable and permanent. This application can keep you accountable for your responsibilities, by keeping track of your own personal to-do list. 
We developed a To-Do List App using a smart contract on the Ethereum platform, which provides the user with the convenience of adding and manipulating descriptors of a task on their personal to-do List, while preserving the events and holding them accountable for their responsibilities. 

# Features
1. User can add a new task to the list
2. User can change the status/completion of the task

# Getting Started
**Installation and Set Up:

Install NodeJS, Solidity, Web3js, Ganache
Create a directory on Desktop and create another folder in that, called list.
Navigate to the list folder
Install truffle
Create folder called appui
Navigate to appui folder and install npm and create npm app 
Open your directory in your IDE
Add List.sol file under contracts. Copy and paste code from GIT
Add 2_deploy_contracts.js file under migrations. Copy and paste code from GIT
Uncomment lines 45-49 and 61-68 in truffle-config.js
Copy and paste code for remaining JS files: config.js, App.js, ShowTasks.js

**Run:

Pull up 2 command prompts.
In one window run ganache through "ganache-cli"
Once ganache is running - copy and paste one account address to "address" in config.js, copy and paste corresponding private key and past after "private key in config.js
In the other window navigate to your project folder, to list and run "truffle migrate" to compile your contract
Get the contract address from the truffle window
In truffle window, run "truffle console" then type in "JSON.stringify(List.abi)". Copy and past everything inside the brackets, including the brackets, to config.js after listAddress
Save all file changes in IDE
Open anotehr command prompt and navigate to the appui folder and run "npm start". 

# Demo Video 
