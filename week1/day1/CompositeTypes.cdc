pub struct Rectangle {
  pub let width: Int
  pub let height: Int

  init(width: Int, height: Int) {
    self.width = width
    self.height = height
  }
}

pub resource Wallet {
  pub var dollars: UInt

  init(dollars: UInt) {
    self.dollars = dollars
  }
}

pub fun main() {
    let square = Rectangle(width: 10, height: 10)
    let myWallet <- create Wallet(dollars: 10)
    destroy myWallet
}