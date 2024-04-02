// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";



contract Governance is Ownable {
    mapping(uint256 => Proposal) public proposals;

    struct Proposal {
        address creator;
        uint256 yesVotes;
        uint256 noVotes;
        bool executed;
        bool result;
    }

    event ProposalCreated(uint256 indexed proposalId, address indexed creator);
    event Voted(uint256 indexed proposalId, address indexed voter, bool decision);
    event ProposalExecuted(uint256 indexed proposalId, bool result);

    constructor(address initialOwner) Ownable(initialOwner) {}

    function createProposal() external onlyOwner returns (uint256) {
        uint256 proposalId = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        proposals[proposalId].creator = msg.sender;
        emit ProposalCreated(proposalId, msg.sender);
        return proposalId;
    }

    // function `castVote` that allows NFT holders to vote on governance decisions. 
    // Ensure only NFT owners can vote, and votes are weighted by the type of NFT owned.
    // function castVote(uint256 proposalId, bool decision) external {
    //     vote(proposalId, decision);
    // }

    function vote(uint256 proposalId, bool decision) external {
        require(proposals[proposalId].creator != address(0), "Proposal does not exist");
        require(!proposals[proposalId].executed, "Proposal already executed");
        require(msg.sender != proposals[proposalId].creator, "Creator cannot vote");

        if (decision) {
            proposals[proposalId].yesVotes++;
        } else {
            proposals[proposalId].noVotes++;
        }

        emit Voted(proposalId, msg.sender, decision);
    }

    function executeProposal(uint256 proposalId) external onlyOwner {
        require(proposals[proposalId].creator != address(0), "Proposal does not exist");
        require(!proposals[proposalId].executed, "Proposal already executed");

        if (proposals[proposalId].yesVotes > proposals[proposalId].noVotes) {
            proposals[proposalId].result = true;
        } else {
            proposals[proposalId].result = false;
        }

        proposals[proposalId].executed = true;
        emit ProposalExecuted(proposalId, proposals[proposalId].result);
    }

    function getProposalResult(uint256 proposalId) external view returns (bool) {
        require(proposals[proposalId].creator != address(0), "Proposal does not exist");
        require(proposals[proposalId].executed, "Proposal not executed");
        return proposals[proposalId].result;
    }

  
}