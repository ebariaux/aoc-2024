import Testing

@testable import AdventOfCode

struct Day04Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

  @Test func helpers() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.width == 10)
    #expect(challenge.height == 10)
    #expect(challenge.letterAt(0, 0) == "M")
    #expect(challenge.letterAt(5, 0) == "X")
    #expect(challenge.letterAt(1, 5) == "X")
    #expect(challenge.letterAt(10, 0) == nil)
    #expect(challenge.letterAt(0, 10) == nil)
  }

  @Test func helpers2() async throws {
    let challenge = Day04(
      data: """
        ABC
        DEF
        """)
    #expect(challenge.width == 3)
    #expect(challenge.height == 2)
    #expect(challenge.letterAt(0, 0) == "A")
    #expect(challenge.letterAt(2, 0) == "C")
    #expect(challenge.letterAt(2, 1) == "F")
    #expect(challenge.letterAt(3, 0) == nil)
    #expect(challenge.letterAt(0, 2) == nil)
  }

  @Test func testPart1() async throws {
    let challenge = Day04(data: testData)
    #expect(String(describing: challenge.part1()) == "18")
  }

  @Test func testPart2() async throws {
    let challenge = Day04(data: testData)
    #expect(String(describing: challenge.part2()) == "9")
  }
}
