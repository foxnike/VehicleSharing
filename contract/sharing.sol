// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract sharing{
    address payable admin;

    constructor() payable {
        admin = payable(msg.sender);
    }
}