pragma solidity >=0.4.22 <0.7.4;
pragma experimental ABIEncoderV2;

contract TodoList{
    
    struct task{
        string name;
        string description;
        uint priority;
        uint dueDate;
        bool completed;
    }
    
    struct timeSys{
        uint sec;
        uint min;
        uint hour;
        uint day;
    }
    
    task[] public generalTasks;
    
    address owner = (msg.sender);
    
    function createTask(string memory _name, string memory _desc, uint _prio, uint _dueDate) public{
        require(msg.sender==owner);
        _dueDate = block.timestamp + _dueDate;
        
        if(_prio > 5 ){
            _prio = 5;
        }
        generalTasks.push(task(_name,_desc,_prio,_dueDate,false));
        
    }
    
    function removeTask(uint _index) public {
        require(msg.sender==owner);
        delete generalTasks[_index];
    }
    
    function editTask(uint _index, string memory _name, string memory _description, uint _prio, uint _dueDate) public {
        // will replace existing if don't want to edit????????
        require(msg.sender==owner);
        generalTasks[_index].name = _name;
        generalTasks[_index].description = _description;
        generalTasks[_index].priority = _prio;
        generalTasks[_index].dueDate = _dueDate;
        
    }
    
    function getTimeLeft(uint _index) public view returns (uint){
        require(msg.sender==owner);
        return (block.timestamp > generalTasks[_index].dueDate ? 0 : generalTasks[_index].dueDate-block.timestamp);
    }
    
    function getCompleted(uint _index) public view returns(bool){
        require(msg.sender==owner);
        return generalTasks[_index].completed;
    }
    
    function toggleComplete(uint _index) public{
        require(msg.sender==owner);
        generalTasks[_index].completed=!generalTasks[_index].completed;
    }
    
}
