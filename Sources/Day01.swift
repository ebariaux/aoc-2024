import Foundation

struct Day01: AdventDay {
  var data: String

  // Split each line in a tuple of Ints
  var entities: ([Int], [Int]) {
    let elements = data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
    return (elements.map { $0[0] }, elements.map { $0[1] })
  }

  func part1() -> Any {
    zip(entities.0.sorted(by: <), entities.1.sorted(by: <)).map { abs($0 - $1) }.reduce(0, +)
  }

  func part2() -> Any {
    entities.0.map { leftNumber in
      entities.1.count(where: { $0 == leftNumber }) * leftNumber
    }
    .reduce(0, +)
  }
}
