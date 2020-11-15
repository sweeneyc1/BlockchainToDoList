pragma solidity >=0.4.22 <0.7.0;

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
        //need to get task then change name 
        
    }
    
    function editDescription(string memory _description) public {
        
    }
    
    function editPriority(uint _prio) public {
        if(_prio > 5 ){
            _prio = 5;
        }
        
    }
    
    function editDueDate(uint _dueDate) public {
        
    }
    
    function markDone() public {
        
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
