pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract List {
    
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
    
    constructor(string[] memory _taskList) public {
        taskList = _taskList;
    }

    function addNewTask(string memory taskName, string memory taskDesc, uint taskTime) public {
        require(msg.sender==owner);

        bytes32 _taskName = stringToBytes32(taskName);
        bytes32 _taskDesc = stringToBytes32(taskDesc);
        
        taskList.push(taskName);
        
        completed[_taskName] = false;
        
        generalTasks.push(task(taskName,taskDesc, taskTime, false));
        
    }
    
    function getTasks() public view returns (string[] memory){
        return taskList;
    }
    
    function toggleComplete(string memory taskName) public{
        //require(msg.sender==owner);
        
        bytes32 _taskName = stringToBytes32(taskName);
        completed[_taskName] = !completed[_taskName];
        //general tasks
    }

    function getCompleted(string memory taskName) public returns(bool){
        //require(msg.sender==owner);
        bytes32 _taskName = stringToBytes32(taskName);
        return completed[_taskName];
    }


    /** 
     * @dev Convert string to bytes32.
     * @param source String source
     * @return bytes32
     * Notes: 
     * - You need to convert movieName from string to bytes32
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
