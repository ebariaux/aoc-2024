import Testing

@testable import AdventOfCode

struct Day11Tests {
  // Smoke test data provided in the challenge question
  let testData = "125 17"

  @Test func stoneCounts() async throws {
    let challenge = Day11(data: testData)

    #expect(challenge.countWithCache(stones: [0], forBlinks: 1) == 1)
    #expect(challenge.countWithCache(stones: [0], forBlinks: 2) == 1)
    #expect(challenge.countWithCache(stones: [0], forBlinks: 3) == 2)
    #expect(challenge.countWithCache(stones: [0], forBlinks: 4) == 4)
    #expect(challenge.countWithCache(stones: [0], forBlinks: 5) == 4)
  }

  @Test func splitStone() async throws {
    let challenge = Day11(data: testData)

    #expect(challenge.splitStone(18) == [1, 8])
    #expect(challenge.splitStone(2024) == [20, 24])
    #expect(challenge.splitStone(1000) == [10, 0])
  }

  @Test func testPart1() async throws {
    let challenge = Day11(data: testData)
    #expect(String(describing: challenge.part1()) == "55312")
  }
}
