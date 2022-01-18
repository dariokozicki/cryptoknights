// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./KnightLib.sol";

contract CryptoKnights is ERC721 {
    using Counters for Counters.Counter;
    using KnightLib for KnightLib.Knight;

    Counters.Counter private _tokenIds; 
    uint256 public mintSize;
    uint256 public mintCost;

    KnightLib.Knight[] public knights;



    constructor(uint256 _mintSize) ERC721("CryptoKnights", "CKNS") {
        mintSize = _mintSize;
        mintCost = 1 ether;
    }

    /// @notice Creates a new Crypto Knight collectible.
    /// @return The id of the created collectible.
    function createCollectible() public payable returns (uint256) {
        require(msg.value == mintCost, "Value sent must match mint cost.");
        _tokenIds.increment();
        uint256 newKnightId = _tokenIds.current();
        require(newKnightId <= mintSize, "CryptoKnights can no longer be minted.");
        _mint(msg.sender, newKnightId);
        //TODO: generate dna for custom characteristics, generate random attack and weapon for rarity 
        knights.push(KnightLib.Knight(newKnightId, 0, 0, 5, 1, 2, msg.sender));
        return newKnightId;
    }

    function attack(uint256 _attackerKnightId, uint256 _receiverKnightId) external {
        knights[_attackerKnightId - 1].attack(knights[_receiverKnightId - 1]);
    }


}