

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

pub fun getBorderLine(width: UInt8): String {
  var line = "+"
  var i:UInt8 = 0
    while i < width {
      line = line.concat("-")
      i = i + 1
    }
  return line.concat("+")
}

pub fun frameCanvas(_ canvas: Canvas): [String] {
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

pub fun display(canvas: Canvas) {
  for line in frameCanvas(canvas) {
    log(line)
  }
}

pub resource Picture {
  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
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
  let canvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )

  let letterX <- create Picture(canvas: canvasX)
  display(canvas: letterX.canvas)
  destroy letterX

}