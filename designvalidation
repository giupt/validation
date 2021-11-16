contract designvalidation is owned {

  event Inserted(address _sender, address _recordId);
  event Updated(address _sender, address _recordId);
  event Deleted(address _sender, address _recordId);

  struct Data {
    string A_projectID;
    string A_designteam;
    address A_designteamaddress;
    uint A_verificationresult;
    uint A_deliverydate;
  }
  struct Record {
    Data data;
    uint idListPointer;
  }

  mapping(address => Record) public Table;
  address[] public IdList;
  string public Name = "designvalidation";

  function Exists(address recordId) public view returns(bool exists) {
    if (IdList.length == 0) return false;
    return (IdList[Table[recordId].idListPointer] == recordId);
  }

  function GetLength() public view returns(uint count) {
    return IdList.length;
  }

  function GetByIndex(uint recordIndex) public returns(address recordId, Data memory record ) {
    require(recordIndex < IdList.length, 'recordIndex-out-of-range');
      return (IdList[recordIndex], Table[IdList[recordIndex]].data);
  }

  function GetById(address recordId) public returns(uint index, Data memory record ) {
    require(Exists(recordId), 'recordId-not-found');
      return (Table[recordId].idListPointer, Table[recordId].data);
  }

  function Insert(Data memory recordData) public authorized returns(bool success) {
    address recordAddress = address(uint160(uint(keccak256(abi.encodePacked(msg.sender, IdList.length, block.timestamp)))));
    require(!Exists(recordAddress), 'recordId-already-exist');
    Table[recordAddress].data = recordData;
    IdList.push(recordAddress);
    Table[recordAddress].idListPointer = IdList.length - 1;
    emit Inserted(msg.sender, recordAddress);
    return true;
  }

  function Update(address recordId, Data memory recordData) public authorized returns(bool success) {
    require(Exists(recordId), 'recordId-not-found');
    Table[recordId].data = recordData;
    emit Updated(msg.sender, recordId);
    return true;
  }

  function Delete(address recordId) public authorized returns(bool success) {
    require(Exists(recordId), 'recordId-not-found');
    uint recordIdListPointerToDelete = Table[recordId].idListPointer;
    address recordIdListPointerToKeep = IdList[IdList.length - 1];
    IdList[recordIdListPointerToDelete] = recordIdListPointerToKeep;
    Table[recordIdListPointerToKeep].idListPointer = recordIdListPointerToDelete;
    IdList.pop();
    emit Deleted(msg.sender, recordId);
    return true;
  }

}
