pragma solidity >=0.4.22 <0.7.0;

contract TodoList{
    
    struct task{
        string name;
        string description;
        uint priority;
        uint dueDate;
        bool completed;
    }
    
    task[] public generalTasks;
    
    function createTask(string memory _name, string memory _desc, uint _prio, uint _dueDate) public{
        _dueDate = block.timestamp + _dueDate;
        
        generalTasks.push(task(_name,_desc,_prio,_dueDate,false));
        
    }
    
    function getTimeLeft(uint _index) public view returns (uint){
        return generalTasks[_index].dueDate-block.timestamp;
    }
    
    function getCompleted(uint _index) public view returns(bool){
        return generalTasks[_index].completed;
    }
    
    function toggleComplete(uint _index) public{
        generalTasks[_index].completed=!generalTasks[_index].completed;
    }
    
}
