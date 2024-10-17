// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SIEMBlockchainIntegration {
    // Owner of the contract
    address public owner;

    // Struct to hold a security event
    struct SecurityEvent {
        uint256 timestamp;      // Timestamp of the event
        string eventType;       // Type of the event, e.g., "intrusion", "malware detection"
        string description;     // Description of the event
        address reporter;       // Address of the SIEM reporter
    }

    // Array to store all security events
    SecurityEvent[] public events;

    // Event to emit when a new security event is logged
    event SecurityEventLogged(uint256 indexed timestamp, string eventType, string description, address indexed reporter);

    // Only the owner or an authorized reporter can add events
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function to log a new security event (called by SIEM system)
    function logSecurityEvent(string memory eventType, string memory description) public onlyOwner {
        // Create a new security event
        SecurityEvent memory newEvent = SecurityEvent({
            timestamp: block.timestamp,
            eventType: eventType,
            description: description,
            reporter: msg.sender
        });

        // Add the event to the blockchain
        events.push(newEvent);

        // Emit the event for transparency
        emit SecurityEventLogged(block.timestamp, eventType, description, msg.sender);
    }

    // Function to retrieve all security events
    function getSecurityEvents() public view returns (SecurityEvent[] memory) {
        return events;
    }

    // Function to get a specific event by index
    function getEventByIndex(uint256 index) public view returns (SecurityEvent memory) {
        require(index < events.length, "Index out of bounds");
        return events[index];
    }
}
