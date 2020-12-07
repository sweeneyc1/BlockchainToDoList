import React, { Component } from 'react';
import './App.css';
import { web3, NETWORK_TYPE, defaultAccount, listContract } from "./config";
import { ShowTasks } from "./ShowTasks";
const Tx = require('ethereumjs-tx').Transaction

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      tasks: [],
      newTaskName: '',
      newTaskDesc: '',
      newTaskTime: ''
    }

    this.handleComplete = this.handleComplete.bind(this);
    this.handleAddingNewTask = this.handleAddingNewTask.bind(this);
    this.handleChangeTaskName = this.handleChangeTaskName.bind(this);
    this.handleChangeTaskDesc = this.handleChangeTaskDesc.bind(this);
    this.handleChangeTaskTime = this.handleChangeTaskTime.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  getCom(taskName) {
    listContract.methods.getCompleted(taskName).call().then((completed) => {
        this.setState({
          tasks: this.state.tasks.map(
            (el) => el.name === taskName ? Object.assign({}, el, { completed: completed }) : el
          )
        })
    })
  }

  async getTaskAsync(taskName) {
      let task = await listContract.methods.getCompleted(taskName).call(); 
      return task;
  }

  async getTaskAsyncTime(taskName) {
    let task = await listContract.methods.getTimeLeft(taskName).call(); 
    return task;
  }

  async getTaskAsyncDesc(taskName) {
    let task = await listContract.methods.getDesc(taskName).call(); 
    return task;
  }

  async loadTasksAsync() {
      let tasks = []
      let taskList = await listContract.methods.getTasks().call();
      for (let task of taskList) {
          let completed = await this.getTaskAsync(task);
          let time = await this.getTaskAsyncTime(task);
          let description = await this.getTaskAsyncDesc(task);
          console.log("completed status " + completed);
          tasks.push({name: task, completed: '' + completed, description: '' + description, 
          time: '' + ('Days: '+(Math.floor(time/86400))+' Hours: '+(Math.floor(time/3600)%24)+' Minutes: '+(Math.floor(time/60)%60)+' Seconds: '+(time%60))
        }); 
          console.log(task);
      }

      this.setState({tasks: tasks});
  }

  async componentDidMount() {
      await this.loadTasksAsync();
  }

  handleComplete(task) { //make handle completed
    console.log("Handle Complete: " + task);
    
    web3.eth.getTransactionCount(defaultAccount.address, (err, txCount) => {
      const txObject = {
        nonce: web3.utils.toHex(txCount),
        gasLimit: web3.utils.toHex(468000), // Raise the gas limit to a much higher amount
        gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'wei')),
        to: listContract._address,
        data: listContract.methods.toggleComplete(task).encodeABI()
      }

      const tx = NETWORK_TYPE === 'private' ? new Tx(txObject) : new Tx(txObject, { 'chain': 'ropsten' });
      tx.sign(Buffer.from(defaultAccount.privateKey.substr(2), 'hex'))

      const serializedTx = tx.serialize()
      const raw = '0x' + serializedTx.toString('hex')

      web3.eth.sendSignedTransaction(raw, (err, txHash) => {
        console.log('err:', err, 'txHash:', txHash)
        if (!err) {
            this.getCom(task);
            this.loadTasksAsync();
        }
      })
    })
  }

  handleAddingNewTask(task, desc, time) {
    console.log("adding: " + task + desc +time);//changed
    web3.eth.getTransactionCount(defaultAccount.address, (err, txCount) => {
      
      const txObject = {
        nonce: web3.utils.toHex(txCount),
        gasLimit: web3.utils.toHex(468000), // Raise the gas limit to a much higher amount
        gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'wei')),
        to: listContract._address,
        data: listContract.methods.addNewTask(task, desc, time).encodeABI() //changed
      }

      const tx = NETWORK_TYPE === 'private' ? new Tx(txObject) : new Tx(txObject, { 'chain': 'ropsten' });
      tx.sign(Buffer.from(defaultAccount.privateKey.substr(2), 'hex'))

      const serializedTx = tx.serialize()
      const raw = '0x' + serializedTx.toString('hex')

      web3.eth.sendSignedTransaction(raw, (err, txHash) => {
        console.log('err:', err, 'txHash:', txHash)
        if (!err) {
            this.loadTasksAsync(); 
        }
      })
    })
  }

  handleChangeTaskName(event) {
    this.setState({newTaskName: event.target.value});
    //console.log(event.target.value);
  }

  handleChangeTaskDesc(event) {
    this.setState({newTaskDesc: event.target.value});
  }

  handleChangeTaskTime(event) {
    this.setState({newTaskTime: event.target.value});
  }

  handleSubmit(event) {
    //alert('A name was submitted: ' + this.state.newTaskName + this.state.newTaskDesc + this.state.newTaskTime);
    //alert('A name was submitted: ' + this.state.newTaskName);
    event.preventDefault();
    this.handleAddingNewTask(this.state.newTaskName, this.state.newTaskDesc, this.state.newTaskTime);
    //this.handleAddingNewTask(this.state.newTaskName);
  }

  render() {
    return (
      <div className="App">
        <p className="App-intro">
          Team 1: Carute, Blockchain Technologies 2020
        </p>
        <form onSubmit={this.handleSubmit}>
        <label>
          Task Name:
          <input type="text" value={this.state.newTaskName} onChange={this.handleChangeTaskName} />
        </label>
      <p>
        <label>
          Task Description:
          <input type="text" value={this.state.newTaskDesc} onChange={this.handleChangeTaskDesc} />
        </label>
      </p>
      <p>
        <label>
          Time to Complete (Seconds):
          <input type="text" value={this.state.newTaskTime} onChange={this.handleChangeTaskTime} />
        </label>
      </p> 
<input type="submit" value="Add New Task" />
</form>
        <div className="task-table">
          <ShowTasks tasks={this.state.tasks} toggleComplete={this.handleComplete} />
          
        </div>
      </div>
    );
  }
}
export default App;
