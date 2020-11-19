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
    
    function createTask(string memory _name, string memory _desc, uint _prio, uint _dueDate) public{
        _dueDate = block.timestamp + _dueDate;
        
        if(_prio > 5 ){
            _prio = 5;
        }
        generalTasks.push(task(_name,_desc,_prio,_dueDate,false));
        
    }
    
    // work in progress
    //function uintToTime(uint _time) public view returns (timeSys memory){
    //    return(timeSys(_time%60,_time/60%60,_time/3600%24,_time/86400));
    //}
    
    function timeToUint(timeSys memory _time) public view returns (uint){
        uint x = 0;
        x = x + _time.sec;
        x = x + _time.min*60;
        x = x + _time.hour*3600;
        x = x + _time.day*86400;
        return(x);
    }
    
    
    
    
    function removeTask(uint _index) public {
        delete generalTasks[_index];
    }
    
    function editTask(uint _index, string memory _name, string memory _description, uint _prio, uint _dueDate) public {
        task storage t = generalTasks[_index];
        // will replace existing if don't want to edit????????
        name = _name;
        description = _description;
        priority = _prio;
        dueDate = _dueDate;
        
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
