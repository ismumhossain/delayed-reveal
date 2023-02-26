// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155DelayedReveal.sol";

error CanNotMintThatMuch();
error CanNotMintMore();
error NotStarted();

contract DelayReveal is ERC1155DelayedReveal {
    constructor(
        string memory _name,
        string memory _symbol
    ) ERC1155DelayedReveal(_name, _symbol, msg.sender, 0) {}

    function verifyClaim(
        address _claimer,
        uint256 _tokenId,
        uint256 _quantity
    ) public view override {
        if(_quantity > 5) {
            revert CanNotMintThatMuch();
        }
        if(this.balanceOf(_claimer, _tokenId) == 5) {
            revert CanNotMintMore();
        }
        if(block.timestamp < 1677378600) {
            revert NotStarted();
        }
    }
}