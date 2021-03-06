pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract List {
    
    
    //task struct
    struct task{
        string name;
        string description;
        uint dueDate;
        bool completed;
    }

    address owner = (msg.sender);
    
    task[] public generalTasks; //tasks of struct with all info about tasks pushed
    string[] public taskList; //list of task names
    mapping (bytes32 => bool) private completed; //list of all tasks to check completion
    
    mapping (bytes32 => string) private descList; //list of task description
    mapping (bytes32 => uint) private timeList; //list of task times
    
    constructor(string[] memory _taskList) public {
        taskList = _taskList;
    }

    //adds new task, maps variables to the task's name string
    function addNewTask(string memory taskName, string memory taskDesc, uint taskTime) public {
    
        bytes32 _taskName = stringToBytes32(taskName);
        
        taskList.push(taskName);
        
        completed[_taskName] = false;
        descList[_taskName] = taskDesc;
        timeList[_taskName] = taskTime;
    }
    
    //returns array of task names
    function getTasks() public view returns (string[] memory){
        return taskList;
    }
    
    //returns description for given task name
    function getDesc(string memory taskName) public view returns (string memory){
        bytes32 _taskName = stringToBytes32(taskName);
        return descList[_taskName];
    }
    
    //returns time for given task name
    function getTimeLeft(string memory taskName) public view returns (uint){
        bytes32 _taskName = stringToBytes32(taskName);
        return timeList[_taskName];
    }

    //toggles the completed boolean for given task name
    function toggleComplete(string memory taskName) public{
        //require(msg.sender==owner);
        
        bytes32 _taskName = stringToBytes32(taskName);
        completed[_taskName] = !completed[_taskName];
        //general tasks
    }

    //returns completed status of a given task
    function getCompleted(string memory taskName) public returns(bool){
        //require(msg.sender==owner);
        bytes32 _taskName = stringToBytes32(taskName);
        return completed[_taskName];
    }


    /** 
     * @dev Convert string to bytes32.
     * @param source String source
     * @return bytes32
     * 
     */
    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }
    
}
