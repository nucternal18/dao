// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Challenge {
    struct ChallengeData {
        uint256 proposalId;
        string description;
        bool resolved;
        address challenger;
    }
    
    function createChallenge(uint256 proposalId, string memory description) external {
        // Implement challenge creation logic
    }

    function resolveChallenge(uint256 challengeId, bool valid) external {
        // Implement challenge resolution fairly
    }
}