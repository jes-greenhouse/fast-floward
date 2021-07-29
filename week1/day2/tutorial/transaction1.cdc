import Hello from 0x01

// transaction(randomParameter: String) {
//   let localVariable: Int
//   prepare(signer: AuthAccount) {}
//   pre {}
//   execute {}
//   post {}
// }


transaction {

  let name: String

  prepare(account: AuthAccount) {
    self.name = account.address.toString()
  }

  execute {
    log(Hello.sayHi(to: self.name))
  }
}
