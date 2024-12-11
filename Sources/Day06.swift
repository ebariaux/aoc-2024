import Foundation

struct Map {
  var grid: Grid
  var currentPosition: Position

  init(data: String) {
    grid = Grid(data: data)
    currentPosition = Position(grid.width, grid.height)

    grid.iterateOverGridElements { position, element in
      if element == Direction.up.rawValue {
        currentPosition = position
        return
      }
    }
  }

  func printMap() {
    grid.printGrid()
  }

  /// Returns direction we're currently heading or nil when outside of map
  mutating func move(_ direction: Direction) -> Direction? {
    guard positionInMap(currentPosition) else { return nil }

    switch direction {
    case .up:
      if letterAt(currentPosition.x, currentPosition.y - 1) == "#" {
        grid[currentPosition] = Direction.right.rawValue
        return move(.right)
      }
      grid[currentPosition] = "X"
      currentPosition.y -= 1
      if positionInMap(currentPosition) {
        grid[currentPosition] = Direction.up.rawValue
      }
    case .left:
      if letterAt(currentPosition.x - 1, currentPosition.y) == "#" {
        grid[currentPosition] = Direction.up.rawValue
        return move(.up)
      }
      grid.elements[currentPosition.y][currentPosition.x] = "X"
      currentPosition.x -= 1
      if positionInMap(currentPosition) {
        grid[currentPosition] = Direction.left.rawValue
      }
    case .right:
      if letterAt(currentPosition.x + 1, currentPosition.y) == "#" {
        grid[currentPosition] = Direction.down.rawValue
        return move(.down)
      }
      grid[currentPosition] = "X"
      currentPosition.x += 1
      if positionInMap(currentPosition) {
        grid[currentPosition] = Direction.right.rawValue
      }
    case .down:
      if letterAt(currentPosition.x, currentPosition.y + 1) == "#" {
        grid[currentPosition] = Direction.left.rawValue
        return move(.left)
      }
      grid[currentPosition] = "X"
      currentPosition.y += 1
      if positionInMap(currentPosition) {
        grid[currentPosition] = Direction.down.rawValue
      }
    }
    return direction
  }

  var visitCount: Int {
    grid.elements.flatMap({ $0 }).count(where: { $0 == "X" })
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
    return grid.elementAt(currentPosition)
  }

  func positionInMap(_ position: Position) -> Bool {
    return grid.isWithinGrid(position)
  }

  func letterAt(_ x: Int, _ y: Int) -> String? {
    return grid.elementAt(x, y)
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
    map.grid.iterateOverGridElements { position, element in
      if position != map.currentPosition {
        var map = self.map
        map.grid[position] = "#"
        if map.isLooping() {
          count += 1
        }
      }
    }
    return count
  }
}
