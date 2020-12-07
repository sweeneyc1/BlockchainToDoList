import Web3 from 'web3';
const NETWORK_TYPE = 'private' //or live 
const ENDPOINT = NETWORK_TYPE === 'private' ? "http://localhost:8545" : "https://ropsten.infura.io/v3/fc5c899d7e854dcb96c11a39e7f6f2cd"
const web3 = new Web3(new Web3.providers.HttpProvider(ENDPOINT))

let defaultAccount = {
    address: '0x0Ca1C75786014cB995424601B0282F3EDcaD637c', // Replace <> with your Metamask wallet account address
    privateKey: '0x6c31e28b038acb85be3358d28ac5cfbc636460feecbe4bdb0105800f632fa34b' 
    // Replace <> with private key of your Metamask wallet account address, prefixed with 0x
}
// Replace [] with list ABI obtained by truffle console. Only the part between [] (inclusive)
let listABI = [{"inputs":[{"internalType":"string[]","name":"_taskList","type":"string[]"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"generalTasks","outputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"dueDate","type":"uint256"},{"internalType":"bool","name":"completed","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"taskList","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"string","name":"taskName","type":"string"},{"internalType":"string","name":"taskDesc","type":"string"},{"internalType":"uint256","name":"taskTime","type":"uint256"}],"name":"addNewTask","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getTasks","outputs":[{"internalType":"string[]","name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"string","name":"taskName","type":"string"}],"name":"getDesc","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"string","name":"taskName","type":"string"}],"name":"toggleComplete","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"string","name":"taskName","type":"string"}],"name":"getCompleted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"}]
let listAddress = '0x4DBb3AaEbc2953d8148751eB8d82278B4C60d9B9';
// Initialize the list contract with web3 
// Reference: https://web3js.readthedocs.io/en/1.0/web3-eth-contract.html
const listContract = new web3.eth.Contract(listABI, listAddress)
export {
    web3,
    NETWORK_TYPE,
    defaultAccount,
    listContract
}
