pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

//Name: Validationcondition
//Description: This validates the result of the verification

import "https://github.com/giupt/validation/blob/main/owned.sol";
import "https://github.com/giupt/validation/blob/main/Idesignvalidation.sol";

contract trigger is owned {
  using SafeMath for uint;

  address designvalidationAddress = 0xA7fBbd94EaC1DEaCCFe6a612DAbA955A6016Dc90;

  function invoke(address _recordId,Idesignvalidation.Data memory designvalidation_Data) public payable returns(bool){

    //Instantiate Global Interfaces
    Idesignvalidation designvalidation = Idesignvalidation(designvalidationAddress);

    //Declare and Initialize Constant Interfaces
    uint256 designvalidation_GetById_index;
    Idesignvalidation.Data memory designvalidation_GetById_record;
    (designvalidation_GetById_index,designvalidation_GetById_record) = designvalidation.GetById(_recordId);

    //Required Payment Options
    require(msg.value == 10000000000000);
          payable(designvalidation_GetById_record.A_designteamaddress).transfer(msg.value);

    //Invoke Required Condition Functions
      Condition0(designvalidation_Data.A_verificationresult);

    //Map Values to Action Interface
    designvalidation_Data.A_designteamaddress = payable(msg.sender);
    designvalidation_Data.A_deliverydate = block.timestamp * 1000;

    //Execute Action
    require(designvalidation.Update(_recordId,designvalidation_Data));

    //Return Success
    return true;
  }

  //Condition Functions
  function Condition0(uint CBI_verificationresult) private pure {
        // 
          require(CBI_verificationresult >= 90);

  }


}
library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
}
