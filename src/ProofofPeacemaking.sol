// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./EIP4973.sol";
import "./Counters.sol";

contract ProofofPeacemaking is ERC4973 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address public deployer;

    constructor() ERC4973("ProofofPeacemaking", "POP") {
        deployer = msg.sender;
    }

    function burn(uint256 _tokenId) external override {
        require(
            ownerOf(_tokenId) == msg.sender || msg.sender == deployer,
            "You can't revoke this token"
        );
        _burn(_tokenId);
    }

    function certify(address _peacemaker, string calldata _uri)
        external
        onlyOwner
    {
        // check if person is eligible through external_url @ _uri
        _tokenIds.increment();
        uint256 newId = _tokenIds.current();
        _mint(_peacemaker, newId, _uri);
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "Not the deployer");
        _;
    }
}
