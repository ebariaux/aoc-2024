import Foundation

struct Day04: AdventDay {
  var data: String
  var grid: Grid

  let xmas = ["X", "M", "A", "S"]
  let samx = ["S", "A", "M", "X"]

  init(data: String) {
    self.data = data
    self.grid = Grid(data: data)
  }

  /// Returns the four letter word written horizontally, starting at given coordinates, if fits within bounds
  func horizontalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = grid.elementAt(x, y),
      let second = grid.elementAt(x + 1, y),
      let third = grid.elementAt(x + 2, y),
      let fourth = grid.elementAt(x + 3, y)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Returns the four letter word written vertically, starting at given coordinates, if fits within bounds
  func verticalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = grid.elementAt(x, y),
      let second = grid.elementAt(x, y + 1),
      let third = grid.elementAt(x, y + 2),
      let fourth = grid.elementAt(x, y + 3)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Returns the four letter word written in a \ pattern, starting at given coordinates, if fits within bounds
  func rightDiagonalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = grid.elementAt(x, y),
      let second = grid.elementAt(x + 1, y + 1),
      let third = grid.elementAt(x + 2, y + 2),
      let fourth = grid.elementAt(x + 3, y + 3)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Returns the four letter word written in a / pattern, starting at given coordinates, if fits within bounds
  func leftDiagonalFourLetterWordAt(_ x: Int, _ y: Int) -> [String]? {
    guard let first = grid.elementAt(x, y),
      let second = grid.elementAt(x - 1, y + 1),
      let third = grid.elementAt(x - 2, y + 2),
      let fourth = grid.elementAt(x - 3, y + 3)
    else { return nil }
    return [first, second, third, fourth]
  }

  /// Is there a MAS or SAM centered at given coordinates in a \ pattern
  func isRightDiagonalValidAt(_ x: Int, _ y: Int) -> Bool {
    if grid.elementAt(x - 1, y - 1) == "M" && grid.elementAt(x + 1, y + 1) == "S" {
      return true
    }
    if grid.elementAt(x - 1, y - 1) == "S" && grid.elementAt(x + 1, y + 1) == "M" {
      return true
    }
    return false
  }

  /// Is there a MAS or SAM centered at given coordinates in a / pattern
  func isLeftDiagonalValidAt(_ x: Int, _ y: Int) -> Bool {
    if grid.elementAt(x + 1, y - 1) == "M" && grid.elementAt(x - 1, y + 1) == "S" {
      return true
    }
    if grid.elementAt(x + 1, y - 1) == "S" && grid.elementAt(x - 1, y + 1) == "M" {
      return true
    }
    return false
  }

  func part1() -> Any {
    var count = 0

    grid.iterateOverGridElements { position, _ in
      if let word = horizontalFourLetterWordAt(position.x, position.y) {
        if word == xmas || word == samx { count += 1 }
      }
      if let word = verticalFourLetterWordAt(position.x, position.y) {
        if word == xmas || word == samx { count += 1 }
      }
      if let word = rightDiagonalFourLetterWordAt(position.x, position.y) {
        if word == xmas || word == samx { count += 1 }
      }
      if let word = leftDiagonalFourLetterWordAt(position.x, position.y) {
        if word == xmas || word == samx { count += 1 }
      }
    }
    return count
  }

  func part2() -> Any {
    var count = 0

    grid.iterateOverGridElements { position, element in
      if element == "A" {
        if isLeftDiagonalValidAt(position.x, position.y)
          && isRightDiagonalValidAt(position.x, position.y)
        {
          count += 1
        }
      }
    }
    return count
  }
}
