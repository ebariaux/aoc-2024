import Foundation

struct Day02: AdventDay {
  var data: String

  // Split each line in an array of Ints
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap {
        Int($0)
      }
    }
  }

  /// Checks if the levels are safe and returns the index of the offending element if not
  /// skippingIndex can optionnaly be used to indicate the index of an level to omit in the check
  func unsafeIndex(_ levels: [Int], skippingIndex: Int? = nil) -> Int? {
    var deltaSign = 0
    var previous: Int?
    for (index, level) in levels.enumerated() {
      if let skippingIndex, skippingIndex == index {
        continue
      }
      if let previous {
        let currentDelta = level - previous
        if abs(currentDelta) < 1 || abs(currentDelta) > 3 {
          return index
        }
        if deltaSign == 0 {
          deltaSign = currentDelta.signum()
        } else {
          if deltaSign != currentDelta.signum() {
            return index
          }
        }
      }
      previous = level
    }
    return nil
  }

  /// Checks if the levels are safe using the Problem Dampener module
  func isSafeDampened(_ levels: [Int]) -> Bool {
    let failingIndex = unsafeIndex(levels)
    guard let failingIndex else { return true }

    // Only the level causing the check or its 2 predecessors can impact the outcome
    // In my first try, I assumed that the level causing the check, the predecessor and the successor
    // could impact. To validate, I created an un-optimized version of this check that would perform the check
    // removing one element at a time, for each element and printing the input levels when there was a discrepancy
    // between the two implementations.
    if failingIndex > 1 {
      if unsafeIndex(levels, skippingIndex: failingIndex - 2) == nil {
        return true
      }
    }
    if failingIndex > 0 {
      if unsafeIndex(levels, skippingIndex: failingIndex - 1) == nil {
        return true
      }
    }
    if unsafeIndex(levels, skippingIndex: failingIndex) == nil {
      return true
    }
    return false
  }

  func part1() -> Any {
    let unsafe = entities.compactMap { unsafeIndex($0) }
    return entities.count - unsafe.count
  }

  func part2() -> Any {
    return entities.map { isSafeDampened($0) }.count(where: { $0 })
  }
}
