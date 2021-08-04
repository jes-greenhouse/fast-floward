import SomeContract from ./some_contract.cdc

pub fun main() {
  // Area 4
  // Variables that can be read: a, b
  log(SomeContract.testStruct.a)
  log(SomeContract.testStruct.b)
  // Variables that can be modified: a
  SomeContract.testStruct.a = "1"
  // Functions that can be accessed: publicFunc
  SomeContract.testStruct.publicFunc()
}