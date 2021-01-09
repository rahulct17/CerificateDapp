pragma solidity >=0.4.0 < 0.6.0;


contract Owned  {
    address owner;


    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier OnlyOwner{
        require(
             msg.sender ==owner ,
            "Only the Owner Can trigger it"
            );
            _;
    }
}

contract Inheritence is Owned{
    
    struct Holder{
        bytes16 name;
        uint level;
    }
    
    mapping(address => Holder) holders;
    
    address[] public holderAccounts;
    
    event HolderInfo(
          bytes16 name,
         uint level
        );
    
    modifier checkLevel(uint _level){
        require(
            _level >= 3,
            "The level is Not recognized."
            );
            _;
    }
    function setHolder(address _address,  bytes16 _name,uint _level)OnlyOwner checkLevel(_level) public{
        holders[_address].name = _name;
        holders[_address].level = _level;
        holderAccounts.push(_address);
        emit HolderInfo(_name,_level);
    }
    
    function getHolders() public view returns(address[] memory){
        return holderAccounts;
        
    }
    
   function getHolder(address _address )public view returns( bytes16,uint){
       return (holders[_address].name,holders[_address].level);
   }
    
    function countHolder() public view returns(uint){
        return holderAccounts.length;
    }
}