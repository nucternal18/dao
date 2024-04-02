// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import './governance_contract/Governance.sol';
import './NFTShares.sol';
// Uncomment this line to use console.log
// import "hardhat/console.sol";




// Interface for compliance checks
interface ICompliance {
    function isCompliant() external view returns (bool);
}

// Interface for dispute resolution
interface IDisputeResolution {
    function resolveDispute() external;
}

contract DAORegistration {
    Governance public governance;
    MultiTypeNFT public multiTypeNFT;
    ICompliance public compliance;
    IDisputeResolution public disputeResolution;

    constructor(address _governance, address _compliance, address _disputeResolution) {
        multiTypeNFT = MultiTypeNFT(msg.sender);
        governance = Governance(_governance);
        compliance = ICompliance(_compliance);
        disputeResolution = IDisputeResolution(_disputeResolution);
    }

    // NFT Issuance
    function mintNFT(
        address to,
        uint256 tokenId,
        MultiTypeNFT.TokenType tokenType,
        uint256 percentageOwnership,
        uint256 value,
        bool hasVotingRights
    ) external {
        multiTypeNFT.mint(to, tokenId, tokenType, percentageOwnership, value, hasVotingRights);
    }

    function getNFTType(uint256 tokenId) external view returns (MultiTypeNFT.TokenType) {
        return multiTypeNFT.getTokenType(tokenId);
    }

    // GOVERNANCE
    // TODO: implememt the function to 'castVotes' that allows NFT holders to vote on governance decisions.
    // Ensure only NFT owners can vote, and votes are weighted by the type of NFT owned.
    function createProposal() external returns (uint256) {
        require(compliance.isCompliant(), "Not compliant");
        return governance.createProposal();
    }

    function vote(uint256 proposalId, bool decision) external {
        require(compliance.isCompliant(), "Not compliant");
        governance.vote(proposalId, decision);
    }

    function executeProposal(uint256 proposalId) external {
        require(compliance.isCompliant(), "Not compliant");
        governance.executeProposal(proposalId);
    }

    // TODO: implement the function to 'resolveDispute' that allows NFT holders to resolve disputes.
    // TODO: implement modifier to check to check compliance with the jurisdictional laws

}
