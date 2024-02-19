// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TaskContract {
    event AddTodo(address recipient, uint256 taskId);
    event DeleteTask(uint256 taskID, bool isDeleted);

    struct Task {
        uint256 taskId;
        string taskText;
        bool isDeleted;
    }

    Task[] private tasks;
    mapping(uint256 => address) taskToOwner;

    function addTask(string memory taskText, bool isDeleted) public {
        uint256 taskId = tasks.length;
        taskToOwner[taskId] = msg.sender;

        tasks.push(Task(taskId, taskText, isDeleted));
        emit AddTodo(msg.sender, taskId);
    }

    function getTasks() external view returns (Task[] memory) {
        Task[] memory temp = new Task[](tasks.length);
        uint256 counter = 0;
        // filtering process
        for (uint256 i = 0; i < tasks.length; i++) {
            if (taskToOwner[i] == msg.sender) {
                temp[counter] = tasks[i];
                counter++;
            }
        }

        // saving it in another array, with length after its obtained precisely by filtering above
        Task[] memory result = new Task[](counter);
        for (uint256 i = 0; i < counter; i++) {
            result[i] = temp[i];
        }

        return result;
    }

    function deleteTask(uint256 taskId, bool isDeleted) external {
        if (taskToOwner[taskId] == msg.sender) {
            tasks[taskId].isDeleted = isDeleted;
            emit DeleteTask(taskId, isDeleted);
        }
    }
}
