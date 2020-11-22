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
    
    //Creates a task and adds it to the tasks array
    function createTask(string memory _name, string memory _desc, uint _prio, uint _dueDate) public{
        require(msg.sender==owner, "Need to be contract owner");
        _dueDate = block.timestamp + _dueDate;
        
        if(_prio > 5 ){
            _prio = 5;
        }
        generalTasks.push(task(_name,_desc,_prio,_dueDate,false));
        
    }
    
    //removes a task at the given index
    function removeTask(uint _index) public {
        require(msg.sender==owner, "Need to be contract owner");
        delete generalTasks[_index];
    }
    
    
    //edits info of a uncompleted tasks
    function editTask(uint _index, string memory _name, string memory _description, uint _prio, uint _dueDate) public {
        require(msg.sender==owner, "Need to be contract owner");
        require(!generalTasks[_index].completed, "Task already completed!");
        
        if(compareStrings(_name, '')){
            generalTasks[_index].name = _name;
        }
        if(compareStrings(_description, '')){
            generalTasks[_index].description = _description;
        }
        if(_prio > 0){
            generalTasks[_index].priority = _prio;
        }
        if(_dueDate > 0){
            generalTasks[_index].dueDate = _dueDate;
        }
    }
    
    //returns time left in seconds before the task's due date is reached (0 if it has reached)
    function getTimeLeft(uint _index) public view returns (uint){
        require(msg.sender==owner, "Need to be contract owner");
        return (block.timestamp > generalTasks[_index].dueDate ? 0 : generalTasks[_index].dueDate-block.timestamp);
    }
    
    //returns completed val of a task in the array
    function getCompleted(uint _index) public view returns(bool){
        require(msg.sender==owner, "Need to be contract owner");
        return generalTasks[_index].completed;
    }
    
    //toggles the completed val of a task in the array
    function toggleComplete(uint _index) public{
        require(msg.sender==owner, "Need to be contract owner");
        generalTasks[_index].completed=!generalTasks[_index].completed;
    }
    
    //compares two strings to see if they are the same
    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
}
