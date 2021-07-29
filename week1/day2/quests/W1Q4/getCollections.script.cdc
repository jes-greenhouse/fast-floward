import Artist from 0x01


pub fun showPictures(_ collectionRef: &Artist.Collection) {
  for key in collectionRef.prints.keys {
    let pictureRef = collectionRef.borrowPicture(key: key)
    display(canvas: pictureRef.canvas)
  }
}


pub fun showCollection(_ address: Address) {
  log ("- Collection for ".concat(address.toString()))
  if let collectionRef = getAccount(address).getCapability<&Artist.Collection>(/public/ArtistCollection).borrow() {
    showPictures(collectionRef)
  } else {
    log("No collection yet")
  }
}


pub fun deserializeString(_ canvas: Artist.Canvas): [String] {
  let lines: [String] = []
  let width = Int(canvas.width)
  let height = Int(canvas.height)
  let pixels = canvas.pixels
  var line = 0
  while line < height {
    let start = line * width
    let end = start + width
    let lineString = pixels.slice(from: start, upTo: end)
    lines.append(lineString)
    line = line + 1
  } 
  return lines
}

pub fun getBorderLine(width: UInt8): String {
  var line = "+"
  var i:UInt8 = 0
    while i < width {
      line = line.concat("-")
      i = i + 1
    }
  return line.concat("+")
}

pub fun frameCanvas(_ canvas: Artist.Canvas): [String] {
  let borderLine = getBorderLine(width: canvas.width)
  let frame : [String] = [borderLine]
  let border = "|"
  for line in deserializeString(canvas) {
    let newLine = border.concat(line).concat(border)
    frame.append(newLine)
  }
  frame.append(borderLine)
  return frame
}

pub fun display(canvas: Artist.Canvas) {
  for line in frameCanvas(canvas) {
    log(line)
  }
}


pub fun main() {
  // Quest W1Q4  

  let addresses: [Address] = [0x01, 0x02, 0x03, 0x04 ,0x05]

  for address in addresses {
    showCollection(address)
  }

}