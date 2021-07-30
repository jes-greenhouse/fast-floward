
import Artist from "./contract.cdc"

// Execute via CLI:
// flow scripts execute ./artist/displayCollection.script.cdc --arg Address:0x01cf0e2f2f715450

// Return an array of formatted Pictures that exist in the account with the a specific address.
// Return nil if that account doesn't have a Picture Collection.
pub fun main(address: Address): [String]? {
    let collectionRef = getAccount(address).getCapability<&Artist.Collection>(/public/ArtistCollection).borrow() ?? panic("No collection")
    if (collectionRef == nil) {
        return nil
    } 

    var buffer: [String] = []
    for canvas in collectionRef.getCanvases() {
        buffer.append(canvas.pixels)
    }

    return buffer
}