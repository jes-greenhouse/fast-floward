import Artist from "./contract.cdc"

// Transaction via CLI:
// flow transactions send ./artist/print.transaction.cdc --signer emulator-artist --arg UInt8:5 --arg UInt8:5 --arg String:"*   * * * * **  * * *****"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {

  let collectionRef: &Artist.Collection
  let picture: @Artist.Picture?

  prepare(account: AuthAccount) {

    // Load collection
    self.collectionRef = account.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow() ?? panic("No collection")

    // Print picture
    let printerRef = account
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    let canvas = Artist.Canvas(
      width: width,
      height: height,
      pixels: pixels
    )
    
    self.picture <- printerRef.print(canvas: canvas)
  }

  execute {
    if (self.picture == nil) {
      log("Picture not printed")
      destroy self.picture
    } else {
      log("Picture printed!")
      self.collectionRef!.deposit(picture: <- self.picture!)
      let length = self.collectionRef!.getLength()
      log("Collection length: ".concat(length.toString()))
    }


}

}
