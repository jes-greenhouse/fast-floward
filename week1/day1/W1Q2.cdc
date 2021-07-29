

pub struct Canvas {

  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width
    self.height = height
    // The following pixels
    // 123
    // 456
    // 789
    // should be serialized as
    // 123456789
    self.pixels = pixels
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }

  return buffer
}

pub fun deserializeString(_ canvas: Canvas): [String] {
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

pub fun display(canvas: Canvas) {
  for line in deserializeString(canvas) {
    log(line)
  }
}

pub resource Picture {
  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

pub resource Printer {
  pub let printed:{String: Canvas}

  pub fun print(canvas: Canvas): @Picture? {
    if (self.printed.containsKey(canvas.pixels)) {
      log("Oops! This picture already exists. Try drawing something else.")
      return nil
    } else {
      let picture <- create Picture(canvas: canvas)
      self.printed[canvas.pixels] = canvas
      display(canvas: canvas)
      return <- picture
    }
  }

  init() {
    self.printed = {}
  }

}

pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]
  let pixelsDash = [
    "     ",
    "     ",
    "*****",
    "     ",
    "     "
  ]
  let canvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )

  let canvasDash = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsDash)
  )

  let printer <- create Printer()

  // Print picture "X"
  let picture <- printer.print(canvas: canvasX)  

  // Try to print picture "X" again
  let picture2 <- printer.print(canvas: canvasX) 

  // Print picture "-"
  let picture3 <- printer.print(canvas: canvasDash) 

  destroy picture
  destroy picture2
  destroy picture3
  destroy printer
}