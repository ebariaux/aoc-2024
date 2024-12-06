import Testing

@testable import AdventOfCode

struct Day05Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

  @Test func mustAppearAfterPage() async throws {
    var rule = PageRule(page: 12)
    rule.add(predecessor: 8)
    rule.add(predecessor: 42)
    #expect(rule.mustAppearAfter(page: 10) == false)
    #expect(rule.mustAppearAfter(page: 12) == false)
    #expect(rule.mustAppearAfter(page: 8) == true)
    #expect(rule.mustAppearAfter(page: 42) == true)
  }

  @Test func anyPagesMustBeBeforeUs() async throws {
    var rule = PageRule(page: 12)
    rule.add(predecessor: 8)
    rule.add(predecessor: 42)
    #expect(rule.anyPagesMustBeBeforeUs([4]) == false)
    #expect(rule.anyPagesMustBeBeforeUs([12, 19, 3]) == false)
    #expect(rule.anyPagesMustBeBeforeUs([8]) == true)
    #expect(rule.anyPagesMustBeBeforeUs([8, 42]) == true)
    #expect(rule.anyPagesMustBeBeforeUs([8, 18, 1]) == true)
  }

  @Test func middlePage() async throws {
    #expect(PageUpdate(pages: [1, 3, 6]).middlePage == 3)
    #expect(PageUpdate(pages: [75, 47, 61, 53, 29]).middlePage == 61)
    #expect(PageUpdate(pages: [97, 13, 75, 29, 47]).middlePage == 75)
  }

  @Test func testPart1() async throws {
    let challenge = Day05(data: testData)
    #expect(String(describing: challenge.part1()) == "143")
  }

  @Test func testPart2() async throws {
    let challenge = Day05(data: testData)
    #expect(String(describing: challenge.part2()) == "123")
  }
}
