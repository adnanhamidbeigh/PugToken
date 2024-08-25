// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {PugToken} from "../src/PugToken.sol";
import {Constants} from "script/Constants.s.sol";

contract DeployPugToken is Script, Constants {
    function run() external returns (PugToken) {
        vm.startBroadcast();
        PugToken pugToken = new PugToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return pugToken;
    }
}
