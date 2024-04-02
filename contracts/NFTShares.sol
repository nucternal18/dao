// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

/**
 * @title MultiTypeNFT
 * @dev Extends ERC721 Non-Fungible Token Standard basic implementation
 * with support for multiple token types.
 * customize the token metadata to reflect the ownership stakes and rights.
 *  
 * */

contract MultiTypeNFT is ERC721Enumerable, Ownable {
    struct TokenInfo {
        uint256 percentageOwnership;
        uint256 value;
        bool hasVotingRights;
    }

    enum TokenType {TypeA, TypeB, TypeC}

    mapping(uint256 => TokenInfo) public tokenInfo;
    mapping(uint256 => TokenType) public tokenTypes;

    constructor(address initialOwner) Ownable(initialOwner) ERC721("MultiTypeNFT", "MTNFT") {}

    function mint(
        address to,
        uint256 tokenId,
        TokenType tokenType,
        uint256 percentageOwnership,
        uint256 value,
        bool hasVotingRights
    ) external onlyOwner {
        require(tokenType == TokenType.TypeA || tokenType == TokenType.TypeB || tokenType == TokenType.TypeC, "Invalid token type");
        _safeMint(to, tokenId);
        tokenInfo[tokenId] = TokenInfo(percentageOwnership, value, hasVotingRights);
        tokenTypes[tokenId] = tokenType;
    }

    function getTokenType(uint256 tokenId) external view returns (TokenType) {
        return tokenTypes[tokenId];
    }

    function _isTokenOwner(address owner, uint256 tokenId) internal view returns (bool) {
        return ownerOf(tokenId) == owner;
    }
}