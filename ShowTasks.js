import React, { Component } from 'react';
import './ShowTasks.css'
export class ShowTasks extends Component {
    handleChange = (task) => {
        let _task = task;
        
        this.props.toggleComplete(_task);
       
    }
    render() {
        
        let taskList = this.props.tasks.map((task, i) =>
            <tr key={i}>
                <td onClick={this.handleChange.bind(this, task.name)}>{task.name}</td>
                <td>{task.description}</td>
                <td>{task.time}</td>
                <td>{task.completed}</td>
            </tr>)
            
        return (
            <div>
                <h3> Tasks </h3>
                <hr />
                <table >
                    <tbody>
                        <tr>
                            <th>Task</th>
                            <th>Description</th>
                            <th>Time</th>
                            <th>Completed</th>
                        </tr>
                        {taskList}
                    </tbody>
                    
                </table>
            </div>
        )
    }
}
module.export = ShowTasks;
