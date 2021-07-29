import Artist from 0x01

transaction() {
  
  let pixels: String
  let picture: @Artist.Picture?
  var collectionRef: &Artist.Collection?

  prepare(account: AuthAccount) {

    // Load collection
    self.collectionRef = account.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow()

    // If there is no collection, create a new one
   if self.collectionRef == nil {
     let newCollection <- Artist.createCollection()
      account.save(<-newCollection, to: /storage/ArtistCollection)
      account.link<&Artist.Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)
      self.collectionRef = account.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow() ?? panic("Couldn't borrow collection reference.")
    }

    // Print picture
    let printerRef = getAccount(0x01)
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    self.pixels = "*   * * * * **  * * *****"
    let canvas = Artist.Canvas(
      width: printerRef.width,
      height: printerRef.height,
      pixels: self.pixels
    )
    
    self.picture <- printerRef.print(canvas: canvas)
  }

  execute {
    if (self.picture == nil) {
      log("Picture with ".concat(self.pixels).concat(" already exists!"))
      destroy self.picture
    } else {
      log("Picture printed!")
      self.collectionRef!.deposit(picture: <- self.picture!)
      let length = self.collectionRef!.getLength()
      log("Collection length: ".concat(length.toString()))
    }
    

  }
}
