import Foundation

struct PageRule {
  private let page: Int
  private var predecessors = [Int]()

  init(page: Int) {
    self.page = page
    predecessors = []
  }

  mutating func add(predecessor: Int) {
    predecessors.append(predecessor)
  }

  func mustAppearAfter(page: Int) -> Bool {
    predecessors.contains(page)
  }

  func anyPagesMustBeBeforeUs(_ pages: ArraySlice<Int>) -> Bool {
    for predecessor in predecessors {
      if pages.contains(predecessor) {
        return true
      }
    }
    return false
  }
}

struct PageUpdate {
  let pages: [Int]

  func isValidFor(rules: [Int: PageRule]) -> Bool {
    for (i, page) in pages[0..<pages.count].enumerated() {
      guard let rule = rules[page] else { continue }

      if rule.anyPagesMustBeBeforeUs(pages[(i + 1)...]) {
        return false
      }
    }
    return true
  }

  func orderedBy(rules: [Int: PageRule]) -> PageUpdate {
    return PageUpdate(
      pages: pages.sorted { p1, p2 in
        if let rule = rules[p1] {
          if rule.mustAppearAfter(page: p2) {
            return false
          }
        }
        return true
      })
  }

  var middlePage: Int {
    pages[pages.count / 2]
  }
}

struct Day05: AdventDay {
  var data: String

  private let rules: [Int: PageRule]
  private let updates: [PageUpdate]

  init(data: String) {
    self.data = data
    let sections = data.split(separator: "\n\n")

    rules = sections[0].split(separator: "\n").reduce(into: [Int: PageRule]()) { result, line in
      // line is e.g. 17|82, indicates 17 must appear before 82 -> p1 is predecessor of p2
      let pages = line.split(separator: "|").map { Int($0) }
      guard let p1 = pages[0], let p2 = pages[1] else { return }

      var pageRule = result[p2] ?? PageRule(page: p2)
      pageRule.add(predecessor: p1)
      result[p2] = pageRule
    }
    updates = sections[1].split(separator: "\n").map {
      PageUpdate(
        pages: $0.split(separator: ",").compactMap {
          Int($0)
        })
    }
  }

  func part1() -> Any {
    var total = 0
    for update in updates {
      if update.isValidFor(rules: rules) {
        total += update.middlePage
      }
    }
    return total
  }

  func part2() -> Any {
    var total = 0
    for update in updates {
      if !update.isValidFor(rules: rules) {
        total += update.orderedBy(rules: rules).middlePage
      }
    }
    return total
  }
}
