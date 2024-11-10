//SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DynamicNFT is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happySVGUri;
    string private s_sadSVGUri;

    enum mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => mood) private s_tokenIdToMood;

    constructor(string memory happySVG, string memory sadSVG) ERC721("Moods", "MDS") {
        s_tokenCounter = 0;
        s_happySVGUri = happySVG;
        s_sadSVGUri = sadSVG;
    }

    function mint() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imgUri = s_happySVGUri;
        if (s_tokenIdToMood[tokenId] == mood.SAD) {
            imgUri = s_sadSVGUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',name(),
                        '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                        '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                        imgUri,
                        '"}'
                    )
                )
            )
        );
    }

    function getHappySVG() public view returns (string memory) {
        return s_happySVGUri;
    }

    function getSadSVG() public view returns (string memory) {
        return s_sadSVGUri;
    }

    function getTokenCounter() public view returns(uint256) {
        return s_tokenCounter;
    }
}
