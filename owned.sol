pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

contract owned {
  address public owner;
  address public newOwner;
  address[] public permissionedList;

  event OwnershipTransferred(address _from, address _to);
  event PermissionAdded(address _address);
  event PermissionRevoked(address _address);

  constructor() public {
    owner = msg.sender;
  }

  modifier isOwner {
    require(msg.sender == owner, 'denied-owner');
    _;
  }

  modifier authorized {
    require(HasPermission(msg.sender));
    _;
  }

  function TransferOwnership(address _newOwner) public isOwner returns(bool success){
    newOwner = _newOwner;
    return true;
  }
  function AcceptOwnership() public returns(bool success){
    require(msg.sender == newOwner, 'denied-new-owner');
    owner = newOwner;
    newOwner = address(0);
    emit OwnershipTransferred(owner, newOwner);
    return true;
  }

  function AddPermission(address addr) public isOwner returns(bool success){
    permissionedList.push(addr);
    emit PermissionAdded(addr);
    return true;
  }

  function RemovePermission(address addr) public isOwner returns(bool success){
    for(uint x = 0; x < permissionedList.length; x++){
      if(addr == permissionedList[x]){
        address keepPermission = permissionedList[permissionedList.length - 1];
        permissionedList[x] = keepPermission;
        permissionedList.pop();
        emit PermissionRevoked(addr);
        return true;
      }
    }
    return false;
  }

  function HasPermission(address sender) public view returns(bool permission){
    if(sender == owner){
      return true;
    }
    for(uint x = 0; x < permissionedList.length; x++){
      if(sender == permissionedList[x]){
        return true;
      }
    }
    return false;
  }

  function GetPermissionListLength() public view returns(uint length){
    return permissionedList.length;
  }

  function GetPermission(uint index) public view returns(address permissionAddress){
    return permissionedList[index];
  }

}
