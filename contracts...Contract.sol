pragma solidity ^0.8.0;

contract CoinFlipper{

    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    
    address owner; 

    
    event CoinFlipped(address player, uint256 amount, uint8 option, bool result); 

    
    constructor() payable {
        owner = msg.sender;
    }

    
    function coinFlip(uint8 _option) public payable returns (bool){ 
        require(_option<3, "Please select Rock Scissors Paper");
        require(msg.value>0, "Please add your bet"); 
        require(msg.value*2 <= address(this).balance, "Contract balance is insuffieient ");

        
        bool result = block.timestamp*block.gaslimit%2 == _option; 
        

       
        emit CoinFlipped(msg.sender, msg.value, _option, result);


        
        if (result){
            payable(msg.sender).transfer(msg.value*2);
            return true;
        }
        
        return false;
        
    }

    
    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

}
