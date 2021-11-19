pragma solidity ^0.8.4;


interface Idesignvalidation {
  struct Data {
    string A_projectID;
    string A_designteam;
    address payable A_designteamaddress;
    uint256 A_verificationresult;
    uint256 A_deliverydate;
  }
  function AcceptOwnership() external returns(bool);
  function AddPermission(address addr) external returns(bool);
  function Delete(address recordId) external returns(bool);
  function Exists(address recordId) external returns(bool);
  function GetById(address recordId) external returns(uint256,Idesignvalidation.Data memory);
  function GetByIndex(uint256 recordIndex) external returns(address,Idesignvalidation.Data memory);
  function GetLength() external returns(uint256);
  function GetPermission(uint256 index) external returns(address);
  function GetPermissionListLength() external returns(uint256);
  function HasPermission(address sender) external returns(bool);
  function IdList(uint256 ) external returns(address);
  function Insert(Idesignvalidation.Data calldata) external returns(bool);
  function Name() external returns(string memory);
  function RemovePermission(address addr) external returns(bool);
  function Table(address ) external returns(Idesignvalidation.Data memory,uint256);
  function TransferOwnership(address _newOwner) external returns(bool);
  function Update(address recordId, Idesignvalidation.Data calldata) external returns(bool);
  function newOwner() external returns(address);
  function owner() external returns(address);
  function permissionedList(uint256 ) external returns(address);
}
