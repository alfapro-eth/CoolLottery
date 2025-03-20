// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoolLottery {
    address public manager; // Address of the lottery organizer
    address[] public players; // Array of players
    uint public lotteryEndTime; // Lottery end timestamp
    bool public ended; // Status of whether the lottery has ended

    event NewPlayer(address player); // Event emitted when a new player joins
    event WinnerSelected(address winner, uint amount); // Event emitted when a winner is picked

    constructor(uint durationInSeconds) {
        manager = msg.sender; // Organizer is the one who deploys the contract
        lotteryEndTime = block.timestamp + durationInSeconds; // Set end time
        ended = false;
    }

    // Function to enter the lottery (requires at least 0.01 ETH)
    function enter() public payable {
        require(block.timestamp < lotteryEndTime, "Lottery has already ended!");
        require(msg.value >= 0.01 ether, "Minimum bet is 0.01 ETH");
        require(!ended, "Lottery is already finished!");

        players.push(msg.sender); // Add player to the array
        emit NewPlayer(msg.sender); // Emit event
    }

    // Generate a pseudo-random number
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    // Pick a winner (only the organizer can call this)
    function pickWinner() public restricted {
        require(block.timestamp >= lotteryEndTime, "Lottery hasn't ended yet!");
        require(!ended, "Winner already picked!");
        require(players.length > 0, "No participants!");

        uint index = random() % players.length; // Random index
        address winner = players[index]; // Select winner
        ended = true; // Mark lottery as ended

        uint prize = address(this).balance; // Entire contract balance is the prize
        payable(winner).transfer(prize); // Send prize to winner

        emit WinnerSelected(winner, prize); // Emit event
    }

    // Modifier: only the organizer can call
    modifier restricted() {
        require(msg.sender == manager, "Only the organizer can do this!");
        _;
    }

    // View contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // View all players
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
