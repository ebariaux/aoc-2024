import Testing

@testable import AdventOfCode

struct Day08Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """

  @Test func allPairs() async throws {
    let challenge = Day08(data: testData)
    // 1 -> []
    // 1, 2 -> (1, 2)
    // 1, 2, 3 -> (1, 2) (1, 3) (2, 3)
    // 1, 2, 3, 4 -> (1, 2) (1, 3) (1, 4) (2, 3) (2, 4) (3, 4)

    #expect(challenge.allPairs([1]).isEmpty)

    // TODO: why can't I check array equality ?
    #expect(challenge.allPairs([1, 2])[0] == (1, 2))
    #expect(challenge.allPairs([1, 2, 3])[0] == (1, 2))
    #expect(challenge.allPairs([1, 2, 3])[1] == (1, 3))
    #expect(challenge.allPairs([1, 2, 3])[2] == (2, 3))
    #expect(challenge.allPairs([1, 2, 3, 4])[0] == (1, 2))
    #expect(challenge.allPairs([1, 2, 3, 4])[1] == (1, 3))
    #expect(challenge.allPairs([1, 2, 3, 4])[2] == (1, 4))
    #expect(challenge.allPairs([1, 2, 3, 4])[3] == (2, 3))
    #expect(challenge.allPairs([1, 2, 3, 4])[4] == (2, 4))
    #expect(challenge.allPairs([1, 2, 3, 4])[5] == (3, 4))
  }

  @Test func testPart1() async throws {
    let challenge = Day08(data: testData)
    #expect(String(describing: challenge.part1()) == "14")
  }

  @Test func testPart2() async throws {
    let challenge = Day08(data: testData)
    #expect(String(describing: challenge.part2()) == "34")
  }
}
