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
        
        if(_prio > 5 ){
            _prio = 5;
        }
        generalTasks.push(task(_name,_desc,_prio,_dueDate,false));
        
    }
    
    function removeTask(uint _index) public returns(bool){
        task storage taskToRemove = generalTasks[_index]; 
        //remove task
    }
    
    function editName(string memory _name) public {
        this.name = _name;
        
    }
    
    function editDescription(string memory _description) public {
        this.description = _description;
    }
    
    function editPriority(uint _prio) public {
        if(_prio > 5 ){
            _prio = 5;
        }
        this.priority = _prio;
    }
    
    function editDueDate(uint _dueDate) public {
        this.dueDate = _dueDate;
    }
    
    function markDone() public {
        this.completed = true;
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
