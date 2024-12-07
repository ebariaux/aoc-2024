import Foundation

enum Direction: String {
  case up = "^"
  case down = "v"
  case left = "<"
  case right = ">"
}

struct Map {
  var characters: [[String]]
  var width: Int
  var height: Int
  var currentPosition: (Int, Int)

  init(data: String) {
    characters = data.split(separator: "\n").map {
      $0.split(separator: "").compactMap {
        String($0)
      }
    }
    width = characters.first?.count ?? 0
    height = characters.count

    for y in 0..<height {
      for x in 0..<width {
        if characters[y][x] == Direction.up.rawValue {
          currentPosition = (x, y)
          return
        }
      }
    }
    currentPosition = (width, height)
  }

  func printMap() {
    for y in 0..<height {
      for x in 0..<width {
        print(characters[y][x], terminator: "")
      }
      print()
    }
    print()
  }

  /// Returns direction we're currently heading or nil when outside of map
  mutating func move(_ direction: Direction) -> Direction? {
    guard positionInMap(currentPosition) else { return nil }

    switch direction {
    case .up:
      if letterAt(currentPosition.0, currentPosition.1 - 1) == "#" {
        characters[currentPosition.1][currentPosition.0] = Direction.right.rawValue
        return move(.right)
      }
      characters[currentPosition.1][currentPosition.0] = "X"
      currentPosition.1 -= 1
      if positionInMap(currentPosition) {
        characters[currentPosition.1][currentPosition.0] = Direction.up.rawValue
      }
    case .left:
      if letterAt(currentPosition.0 - 1, currentPosition.1) == "#" {
        characters[currentPosition.1][currentPosition.0] = Direction.up.rawValue
        return move(.up)
      }
      characters[currentPosition.1][currentPosition.0] = "X"
      currentPosition.0 -= 1
      if positionInMap(currentPosition) {
        characters[currentPosition.1][currentPosition.0] = Direction.left.rawValue
      }
    case .right:
      if letterAt(currentPosition.0 + 1, currentPosition.1) == "#" {
        characters[currentPosition.1][currentPosition.0] = Direction.down.rawValue
        return move(.down)
      }
      characters[currentPosition.1][currentPosition.0] = "X"
      currentPosition.0 += 1
      if positionInMap(currentPosition) {
        characters[currentPosition.1][currentPosition.0] = Direction.right.rawValue
      }
    case .down:
      if letterAt(currentPosition.0, currentPosition.1 + 1) == "#" {
        characters[currentPosition.1][currentPosition.0] = Direction.left.rawValue
        return move(.left)
      }
      characters[currentPosition.1][currentPosition.0] = "X"
      currentPosition.1 += 1
      if positionInMap(currentPosition) {
        characters[currentPosition.1][currentPosition.0] = Direction.down.rawValue
      }
    }
    return direction
  }

  var visitCount: Int {
    characters.flatMap({ $0 }).count(where: { $0 == "X" })
  }

  /// Detect if there's a loop in the map
  mutating func isLooping() -> Bool {
    var moves = 0
    var direction: Direction? = .up
    var previousMovesCounts = [Int]()

    // Remember the number of moves between each turn
    while direction != nil {
      let initialDirection = direction
      direction = move(direction!)

      if direction == initialDirection {
        moves += 1
      } else {
        previousMovesCounts.append(moves)
        moves = 0

        // Doing the same 4 or more moves 2 times in a row means we're in an infinite loop
        if previousMovesCounts.count > 7 {
          for size in 4...previousMovesCounts.count / 2 {
            let lastRange =
              previousMovesCounts.index(
                previousMovesCounts.endIndex, offsetBy: -size)..<previousMovesCounts.endIndex
            let previousRange =
              previousMovesCounts.index(
                previousMovesCounts.endIndex, offsetBy: -size * 2)..<previousMovesCounts.index(
                previousMovesCounts.endIndex, offsetBy: -size)
            if previousMovesCounts[previousRange] == previousMovesCounts[lastRange] {
              return true
            }
          }
        }
      }
    }
    return false
  }

  func currentCharacter() -> String? {
    guard positionInMap(currentPosition) else { return nil }

    return characters[currentPosition.1][currentPosition.0]
  }

  func positionInMap(_ position: (Int, Int)) -> Bool {
    let (x, y) = position
    return x >= 0 && x < width && y >= 0 && y < height
  }

  func letterAt(_ x: Int, _ y: Int) -> String? {
    if x < 0 || x >= width || y < 0 || y >= height { return nil }
    return characters[y][x]
  }
}

struct Day06: AdventDay {
  var data: String
  var map: Map

  init(data: String) {
    self.data = data
    map = Map(data: data)
  }

  func part1() -> Any {
    var map = self.map
    var direction: Direction? = .up
    while direction != nil {
      direction = map.move(direction!)
    }
    return map.visitCount
  }

  func part2() -> Any {
    var count = 0
    for y in 0..<map.height {
      for x in 0..<map.width {
        if (x, y) == map.currentPosition {
          continue
        }
        var map = self.map
        map.characters[y][x] = "#"
        if map.isLooping() {
          count += 1
        }
      }
    }
    return count
  }
}
