import Foundation

struct Day11: AdventDay {
  var stones: [Int]

  init(data: String) {
    stones = data.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).split(
      separator: " "
    ).map { Int($0)! }
  }

  func splitStone(_ stone: Int) -> [Int] {
    for i in 1...10 {
      let divisor = Int(pow(10.0, Double(i)))
      if stone >= divisor && stone < divisor * divisor {
        return [stone / divisor, stone % divisor]
      }
    }
    fatalError("Number too big")

    // Initially had the split using String conversions, reoplaced with optimized (not measured) version using math operations
    // let stoneString = String(stone)
    // let middleIndex = stoneString.index(stoneString.startIndex, offsetBy: stoneString.count/2)
    // return [Int(stoneString[stoneString.startIndex..<middleIndex])!, Int(stoneString[middleIndex...])!]
  }

  func blink(stones: [Int]) -> [Int] {
    var newStones = [Int]()
    for stone in stones {
      if stone == 0 {
        newStones.append(1)
      } else if String(stone).count % 2 == 0 {
        newStones.append(contentsOf: splitStone(stone))
      } else {
        newStones.append(2024 * stone)
      }
    }
    return newStones
  }

  func countWithCache(stones: [Int], forBlinks blinks: Int) -> Int {
    var cache: [Int: [Int: Int]] = [:]  // Index per value, then per blinks level

    func stoneCounts(stones: [Int], forBlinks blinks: Int) -> Int {
      var total = 0

      if blinks == 0 {
        return stones.count
      }

      for stone in stones {
        var blinksCache = cache[stone] ?? [:]
        if let countCache = blinksCache[blinks] {
          total += countCache
        } else {
          let count = stoneCounts(stones: blink(stones: [stone]), forBlinks: blinks - 1)
          blinksCache[blinks] = count
          total += count
        }
        cache[stone] = blinksCache
      }

      return total
    }

    return stoneCounts(stones: stones, forBlinks: blinks)
  }

  func part1() -> Any {
    return countWithCache(stones: self.stones, forBlinks: 25)
  }

  func part2() -> Any {
    countWithCache(stones: self.stones, forBlinks: 75)
  }
}
