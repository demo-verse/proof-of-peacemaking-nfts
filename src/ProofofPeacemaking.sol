// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./EIP4973.sol";
import "./Counters.sol";

/// @title an Expression of Peace, building social contract/consensus around Proof of Peacemaking (PoP)
/// @dev https://github.com/demo-verse/expressions-metadata-specification

contract ProofofPeacemaking is ERC4973 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address public deployer;
    // bool eligible = false;

    constructor() ERC4973("ProofofPeacemaking", "POP") {
        deployer = msg.sender;
    }

    /// @dev Please consult https://github.com/demo-verse/expressions-metadata-specification#design-considerations
    //  TODO: with expression_id and using Chainlink oracles,
    //  check if msg.sender is included in the eligible peacemaker list or not.
    // function isEligible() returns (bool) {
    //      ....
    // }

    function burn(uint256 _tokenId) external override {
        require(
            ownerOf(_tokenId) == msg.sender || msg.sender == deployer,
            "You can't revoke this token"
        );
        _burn(_tokenId);
    }

    function certify(address _peacemaker, string calldata _uri)
        external
        // , string calldata expression_id
        onlyOwner
    {
        //  TODO: add a require statement with isEligible() check.
        // TODO: peacemakers should also be able to mint for themselves. (onlyOwner is no good)
        _tokenIds.increment();
        uint256 newId = _tokenIds.current();
        _mint(_peacemaker, newId, _uri);
    }

    modifier onlyOwner() {
        require(msg.sender == deployer, "Not the deployer");
        _;
    }
}
