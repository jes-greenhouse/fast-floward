// flow scripts execute hello/sayHi.script.cdc \
//   --arg String:"FastFloward"

import Hello from "./contract.cdc"

pub fun main(name: String): String {
  return Hello.sayHi(to: name)
}
