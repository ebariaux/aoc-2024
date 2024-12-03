import Foundation

struct Day03: AdventDay {
  var data: String

  func part1() -> Any {
    let mulPattern = /mul\(([0-9]{1,3}),([0-9]{1,3})\)/
    return data.matches(of: mulPattern).map { Int($0.output.1)! * Int($0.output.2)! }.reduce(0, +)
  }

  func part2() -> Any {
    let conditionalPattern = /mul\(([0-9]{1,3}),([0-9]{1,3})\)|do\(\)|don't\(\)/
    let matches = data.matches(of: conditionalPattern).map { $0.output }
    var enabled = true
    var total = 0
    for match in matches {
      switch match.0 {
      case "do()":
        enabled = true
      case "don't()":
        enabled = false
      default:
        if enabled {
          total += Int(match.1!)! * Int(match.2!)!
        }
      }
    }
    return total
  }
}
