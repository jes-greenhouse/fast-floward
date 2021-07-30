import Artist from "./contract.cdc"

// Transaction via CLI:
// flow transactions send ./artist/createCollection.transaction.cdc --signer emulator-artist

// Create a Picture Collection for the transaction authorizer.
transaction {

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
  }

  execute {
    if (self.collectionRef != nil) {
      log("Picture Collection available")
    } else {
       log("Could not create Picture Collection")
    }
   }
}
