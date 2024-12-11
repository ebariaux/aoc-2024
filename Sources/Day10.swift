import Foundation

struct Day10: AdventDay {
  var grid: Grid
  // TODO: make grid generic to support Int

  init(data: String) {
    grid = Grid(data: data)
  }

  func findTrailheads(isScore: Bool) -> Int {
    var total = 0
    var trailEnds = [Position]()

    func findTrailhead(currentPosition: Position, currentValue: Int = 0) {
      if currentValue == 9 {
        trailEnds.append(currentPosition)
        return
      }
      for d in Direction.allCases {
        if let nextValue = grid.elementAt(currentPosition.moving(d)),
          nextValue == String(currentValue + 1)
        {
          findTrailhead(currentPosition: currentPosition.moving(d), currentValue: currentValue + 1)
        }
      }
    }

    grid.iterateOverGridElements { position, element in
      if element == "0" {
        trailEnds.removeAll()
        findTrailhead(currentPosition: position, currentValue: 0)
        if isScore {
          total += Set(trailEnds).count
        } else {
          total += trailEnds.count
        }
      }
    }
    return total
  }

  func part1() -> Any {
    findTrailheads(isScore: true)
  }

  func part2() -> Any {
    findTrailheads(isScore: false)
  }
}
