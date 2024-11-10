//SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import {Script} from "forge-std/Script.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";



contract DeployDynamicNFT is Script {
    DynamicNFT nft;

    function run() external returns (DynamicNFT) {
        string memory sadSVG = vm.readFile("./images/sad.svg");
        string memory happySVG = vm.readFile("./images/happy.svg");
        vm.startBroadcast();
        nft = new DynamicNFT(svgToUri(happySVG),svgToUri(sadSVG));
        vm.stopBroadcast();
        return nft;
    }

    function svgToUri(string memory svg) public pure returns (string memory) {
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory svgUri = string(abi.encodePacked(baseUri, Base64.encode(abi.encodePacked(svg))));
        return svgUri;
    }
}
