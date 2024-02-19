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
}
