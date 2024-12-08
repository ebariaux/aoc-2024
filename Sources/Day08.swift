import Foundation

struct Position: Hashable {
  var x: Int
  var y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  func offsetFrom(_ position: Position) -> (Int, Int) {
    (x - position.x, y - position.y)
  }

  func addingOffset(_ offset: (Int, Int)) -> Position {
    Position(x + offset.0, y + offset.1)
  }

  func subtractingOffset(_ offset: (Int, Int)) -> Position {
    Position(x - offset.0, y - offset.1)
  }
}

struct Grid {
  var characters: [[String]]
  var width: Int
  var height: Int

  init(data: String) {
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

  func isWithinGrid(_ position: Position) -> Bool {
    isWithinGrid(position.x, position.y)
  }

  func isWithinGrid(_ x: Int, _ y: Int) -> Bool {
    x >= 0 && x < width && y >= 0 && y < height
  }

  func printGrid() {
    for y in 0..<height {
      for x in 0..<width {
        print(characters[y][x], terminator: "")
      }
      print()
    }
    print()
  }
}

extension String {
  func isAlphanumeric() -> Bool {
    return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
  }
}

struct Day08: AdventDay {
  var data: String
  var grid: Grid

  init(data: String) {
    self.data = data
    grid = Grid(data: data)
  }

  var antennas: [String: [Position]] {
    var result: [String: [Position]] = [:]

    for y in 0..<grid.height {
      for x in 0..<grid.width {
        if let symbol = grid.letterAt(x, y) {
          if symbol.isAlphanumeric() {
            if result[symbol] != nil {
              result[symbol]!.append(Position(x, y))
            } else {
              result[symbol] = [Position(x, y)]
            }
          }
        }
      }
    }
    return result
  }

  func allPairs<T>(_ array: [T]) -> [(T, T)] {
    guard array.count > 1 else { return [] }

    var result: [(T, T)] = []
    for (i, element) in array.enumerated() {
      for otherElement in array[array.index(after: i)...] {
        result.append((element, otherElement))
      }
    }

    return result
  }

  func antinodes(_ position1: Position, _ position2: Position) -> [Position] {
    var result = [Position]()
    let offset = position1.offsetFrom(position2)
    if grid.isWithinGrid(position1.addingOffset(offset)) {
      result.append(position1.addingOffset(offset))
    }
    if grid.isWithinGrid(position2.subtractingOffset(offset)) {
      result.append(position2.subtractingOffset(offset))
    }
    return result
  }

  func antinodesResonant(_ position1: Position, _ position2: Position) -> [Position] {
    var result = [Position]()
    let offset = position1.offsetFrom(position2)

    var position = position1
    while grid.isWithinGrid(position) {
      result.append(position)
      position = position.addingOffset(offset)
    }

    position = position2
    while grid.isWithinGrid(position) {
      result.append(position)
      position = position.subtractingOffset(offset)
    }
    return result
  }

  func part1() -> Any {
    let antennas = self.antennas

    var antinodes = Set<Position>()

    for (_, positions) in antennas {
      for pairs in allPairs(positions) {
        for position in self.antinodes(pairs.0, pairs.1) {
          antinodes.insert(position)
        }
      }
    }

    return antinodes.count
  }

  func part2() -> Any {
    let antennas = self.antennas

    var antinodes = Set<Position>()

    for (_, positions) in antennas {
      for pairs in allPairs(positions) {
        for position in self.antinodesResonant(pairs.0, pairs.1) {
          antinodes.insert(position)
        }
      }
    }

    return antinodes.count
  }
}
