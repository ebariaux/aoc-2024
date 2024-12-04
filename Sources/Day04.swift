import Foundation

struct Day04: AdventDay {
  var data: String
  var characters: [[String]]
  var width: Int
  var height: Int
  let xmas = ["X", "M", "A", "S"]
  let samx = ["S", "A", "M", "X"]

  init(data: String) {
    self.data = data
    characters = data.split(separator: "\n").map {
      $0.split(separator: "").compactMap {
        String($0)
      }
    }
    width = characters.first?.count ?? 0
    height = characters.count
  }

  func letterAt(_ x: Int, _ y: Int) -> String? {
    if x < 0 || x >= width || y < 0 || y >= height { return nil }
    return characters[y][x]
  }

  /// Returns the four letter word written horizontally, starting at given coordinates, if fits within bounds
  func horizontalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = letterAt(x, y),
      let second = letterAt(x + 1, y),
      let third = letterAt(x + 2, y),
      let fourth = letterAt(x + 3, y)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Returns the four letter word written vertically, starting at given coordinates, if fits within bounds
  func verticalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = letterAt(x, y),
      let second = letterAt(x, y + 1),
      let third = letterAt(x, y + 2),
      let fourth = letterAt(x, y + 3)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Returns the four letter word written in a \ pattern, starting at given coordinates, if fits within bounds
  func rightDiagonalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = letterAt(x, y),
      let second = letterAt(x + 1, y + 1),
      let third = letterAt(x + 2, y + 2),
      let fourth = letterAt(x + 3, y + 3)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Returns the four letter word written in a / pattern, starting at given coordinates, if fits within bounds
  func leftDiagonalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = letterAt(x, y),
      let second = letterAt(x - 1, y + 1),
      let third = letterAt(x - 2, y + 2),
      let fourth = letterAt(x - 3, y + 3)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Is there a MAS or SAM centered at given coordinates in a \ pattern
  func isRightDiagonalValidAt(_ x: Int, _ y: Int) -> Bool {
    if letterAt(x - 1, y - 1) == "M" && letterAt(x + 1, y + 1) == "S" {
      return true
    }
    if letterAt(x - 1, y - 1) == "S" && letterAt(x + 1, y + 1) == "M" {
      return true
    }
    return false
  }

  /// Is there a MAS or SAM centered at given coordinates in a / pattern
  func isLeftDiagonalValidAt(_ x: Int, _ y: Int) -> Bool {
    if letterAt(x + 1, y - 1) == "M" && letterAt(x - 1, y + 1) == "S" {
      return true
    }
    if letterAt(x + 1, y - 1) == "S" && letterAt(x - 1, y + 1) == "M" {
      return true
    }
    return false
  }

  func part1() -> Any {
    var count = 0

    for y in 0..<height {
      for x in 0..<width {
        if let word = horizontalFourLetterWordAt(x, y) {
          if word == xmas || word == samx { count += 1 }
        }
        if let word = verticalFourLetterWordAt(x, y) {
          if word == xmas || word == samx { count += 1 }
        }
        if let word = rightDiagonalFourLetterWordAt(x, y) {
          if word == xmas || word == samx { count += 1 }
        }
        if let word = leftDiagonalFourLetterWordAt(x, y) {
          if word == xmas || word == samx { count += 1 }
        }
      }
    }
    return count
  }

  func part2() -> Any {
    var count = 0

    for y in 0..<height - 1 {
      for x in 0..<width - 1 {
        if letterAt(x, y) != "A" { continue }
        if isLeftDiagonalValidAt(x, y) && isRightDiagonalValidAt(x, y) {
          count += 1
        }
      }
    }
    return count
  }
}
