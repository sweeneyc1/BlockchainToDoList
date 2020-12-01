pragma solidity >=0.4.22 <0.7.4;
pragma experimental ABIEncoderV2;

contract TodoList{
    
    struct task{
        string name;
        string description;
        uint dueDate;
        bool completed;
    }
    
    address owner = (msg.sender);
    
    task[] public generalTasks;
    
    constructor(string[] memory _test) public {
        for(uint x = 0; x < _test.length; x++){
            generalTasks.push(task(_test[x],"desc",600,false));
        }
    }
    
    
    function createTask(string memory _name, string memory _desc, uint _dueDate) public{
        require(msg.sender==owner);
        _dueDate = block.timestamp + _dueDate;
        
        
        generalTasks.push(task(_name,_desc,_dueDate,false));
        
    }
    
    function removeTask(uint _index) public {
        require(msg.sender==owner);
        delete generalTasks[_index];
    }
    
    function editTask(uint _index, string memory _name, string memory _description, uint _dueDate) public {
        // will replace existing if don't want to edit????????
        require(msg.sender==owner);
        generalTasks[_index].name = _name;
        generalTasks[_index].description = _description;
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
