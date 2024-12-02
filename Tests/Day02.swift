import Testing

@testable import AdventOfCode

struct Day02Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

  @Test(
    "Levels sequence is safe",
    arguments: zip(
      [
        [7, 6, 4, 2, 1],
        [1, 2, 3],
        [1, 2, 4, 7, 8],
        [1, 3, 2],
        [1, 7, 9],
        [1, 1, 2],
      ],
      [
        nil,
        nil,
        nil,
        2,
        1,
        1,
      ]))
  func isSafe(levels: [Int], answer: Int?) async throws {
    let challenge = Day02()
    #expect(challenge.unsafeIndex(levels) == answer)
  }

  @Test(
    "Levels sequence is safe using Problem Dampener",
    arguments: zip(
      [
        [7, 6, 4, 2, 1],
        [1, 2, 3],
        [1, 2, 4, 7, 8],
        [1, 3, 2],
        [1, 7, 9],
        [1, 1, 2],
        [5, 4, 6, 8],
        [5, 4, 9, 10],
        [5, 10, 5, 6],
        [5, 6, 10, 10, 11],
        [67, 70, 67, 65, 64],
      ],
      [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        false,
        false,
        false,
        true,
      ]))
  func isSafeDampen(levels: [Int], answer: Bool) async throws {
    let challenge = Day02()
    #expect(challenge.isSafeDampened(levels) == answer)
  }

  @Test func testPart1() async throws {
    let challenge = Day02(data: testData)
    #expect(String(describing: challenge.part1()) == "2")
  }

  @Test func testPart2() async throws {
    let challenge = Day02(data: testData)
    #expect(String(describing: challenge.part2()) == "4")
  }

  @Test("Demo", arguments: [1, 1, 1])
  func simpleTest(a: Int) async throws {
    #expect(a == 1)
  }
}
