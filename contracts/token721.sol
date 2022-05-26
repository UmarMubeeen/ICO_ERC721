//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";


contract token721 is ERC721, ERC721Enumerable{

    using SafeMath for uint;
    using Counters for Counters.Counter;
    Counters.Counter private tokenIdCounter;

    address public owner ;
    uint public maxSupply;

    constructor(
        string memory name,
        string memory symbol,
        uint _maxSupply

    ) ERC721(name , symbol){

        require(msg.sender != address(0), "owner cannot be Address(0)");
        owner = msg.sender;

        maxSupply = _maxSupply;
    }

    modifier ownerOnly(){
        require(msg.sender == owner, "only owner is authorized to call");
        _;
    }

    function _mintToken( address _to) external {

        require(_to != address(0), "invalid address");
        tokenIdCounter.increment();
        uint tokenId = tokenIdCounter.current();
        
        require(!_exists(tokenId), "token already minted");
        require(maxSupply != 0, "max Supply cannot be equal to zero");
        require(tokenId <= maxSupply, "Cannot mint more than maximum supply limit");

            _safeMint(_to, tokenId);
    }

    function _beforeTokenTransfer(
        address from, 
        address to, 
        uint256 tokenId) internal override(ERC721, ERC721Enumerable){
        super._beforeTokenTransfer(from, to , tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override (ERC721, ERC721Enumerable)returns (bool){
       return super.supportsInterface(interfaceId);
    }
}

