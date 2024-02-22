// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Structure to represent a single voting option
    struct Option {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Array to store all voting options
    Option[] public options;

    // Mapping to keep track of whether an address has voted
    mapping(address => bool) public hasVoted;

    // Event to emit when a new vote is cast
    event VoteCasted(address indexed voter, uint256 optionId);

    // Function to add a new voting option
    function addOption(string memory _name) external {
        uint256 optionId = options.length;
        options.push(Option(optionId, _name, 0));
    }

    // Function to cast a vote for a specific option
    function vote(uint256 _optionId) external {
        require(_optionId < options.length, "Invalid option ID");
        require(!hasVoted[msg.sender], "You have already voted");

        options[_optionId].voteCount++;
        hasVoted[msg.sender] = true;

        emit VoteCasted(msg.sender, _optionId);
    }
}
