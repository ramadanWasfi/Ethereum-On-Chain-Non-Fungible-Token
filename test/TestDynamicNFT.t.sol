//SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";
import {console} from "forge-std/console.sol";
import {DeployDynamicNFT} from "../script/DeployDynamicNFT.s.sol";

contract TestDynamicNFT is Test {
    DynamicNFT nft;
    address user1;
    DeployDynamicNFT deployer;
    string private constant NFT_NAME = "Moods";
    string private constant NFT_SYMBOL = "MDS";

    function setUp() public {
        deployer = new DeployDynamicNFT();
        nft = deployer.run();
        user1 = makeAddr("user1");
    }

    function testTokenUri() public {
        vm.prank(user1);
        nft.mint();
        assertEq(nft.balanceOf(user1), 1, "Token should be minted");

    // Get the token URI
    string memory uri = nft.tokenURI(0);

        console.log(uri);
    }

    function testNFTDeployedCorrectly() public view {
        string memory name = nft.name();
        string memory symbol = nft.symbol();
        assertEq(keccak256(abi.encodePacked(name)) , keccak256(abi.encodePacked(NFT_NAME)));
        assertEq(keccak256(abi.encodePacked(symbol)) , keccak256(abi.encodePacked(NFT_SYMBOL)));
    }


    
}
