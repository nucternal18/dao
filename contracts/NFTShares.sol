// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTShares is ERC721 {
    enum NFTType { TypeA, TypeB, TypeC }

    struct NFTMetadata {
        uint256 percentage;
        uint256 value;
        bool hasVotingRights;
    }

    mapping(uint256 => NFTMetadata) public nftMetadata;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function issueNFT(address recipient, uint256 tokenId, NFTType nftType, uint256 percentage, uint256 value, bool hasVotingRights) external {
        require(nftType == NFTType.TypeA || nftType == NFTType.TypeB || nftType == NFTType.TypeC, "Invalid NFT type");
        _mint(recipient, tokenId);
        nftMetadata[tokenId] = NFTMetadata(percentage, value, hasVotingRights);
    }
}