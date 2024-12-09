import Foundation

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

  var antennas: MultiValueDictionary<String, Position> {
    var result = MultiValueDictionary<String, Position>()

    grid.iterateOverGridElements { position, symbol in
      if symbol.isAlphanumeric() {
        result[symbol] = position
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

    for (_, positions) in antennas.dict {
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

    for (_, positions) in antennas.dict {
      for pairs in allPairs(positions) {
        for position in self.antinodesResonant(pairs.0, pairs.1) {
          antinodes.insert(position)
        }
      }
    }

    return antinodes.count
  }
}
