//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./token721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";


contract crowdSale721{

    using SafeMath for uint;
    address public  owner;
    uint public startSaleTime;
    uint public closeSaleTime;
    uint public price;
    uint public minPurchase;
    uint public maxPurchase;
    token721 public Token;

    constructor(
        uint _startSaleTime,
        uint _closeSaleTime,
        uint _price,
        uint _minPurchase,
        uint _maxPurchase,
        token721 _Token   
    ){
        // token721 token= token721(_Token);
        // owner = token.owner();
        owner = msg.sender;
        
        startSaleTime =  _startSaleTime;
        closeSaleTime = _closeSaleTime;

        require(_startSaleTime > 0, "starting sale time sale cannot be equal to zero");
        require(_closeSaleTime != _startSaleTime, "starting and ending sale time should not be same");
        require(_startSaleTime <_closeSaleTime, "starting sale time must be less than ending sale time");

        price = _price;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
        Token = _Token;

    }


    modifier ownerOnly{
        require(msg.sender == owner, "only owner is authorized to call saleowner");
        _;
    }

    modifier onlyWhileActive{
        require(block.timestamp > startSaleTime && block.timestamp <closeSaleTime, "The token Sale must be active");
        _;
    }
    

    modifier onlyWhenClosed{
        require(block.timestamp > closeSaleTime, "The token sale must be closed");
        _;  

    }

    function saleActiveStatus() public view returns (bool status){

        if(block.timestamp > startSaleTime && block.timestamp < closeSaleTime){
            return true;
        }
        if(block.timestamp > closeSaleTime){
            return false;
        }
    }

    // function tokenMint() public ownerOnly(){
    //     Token._mintToken(address(this));
    // }

    function buyToken(uint tokenAmount) external onlyWhileActive() payable{

        address buyer = msg.sender;

        require(buyer != address(0), "buyer cannot be equal to address(0)");
        require(msg.value != 0 , "value send cannot be equal to zero");
        require(tokenAmount != 0 , "Token amount must be greater than zero");
        require(tokenAmount == minPurchase, "token amount less than minimum purchase limit: 'min 1 allowed'");
        require(tokenAmount == maxPurchase, "token amount more than maximum purchase limit: 'max 1 allowed'");


        uint tokenValue = tokenAmount * price;
        require(msg.value == tokenValue, "insufficient amount to buy token");

        Token._mintToken(buyer);
        // Token.transferFrom(address(this), buyer, 1);

    }

    function withdrawether() external ownerOnly() onlyWhenClosed(){

        payable(owner).transfer(address(this).balance);
    }


}
