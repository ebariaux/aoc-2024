import Testing

@testable import AdventOfCode

struct Day09Tests {
  // Smoke test data provided in the challenge question
  let testData = "2333133121414131402"
  let testData2 = "12345"

  let compressedMap = "0099811188827773336446555566"
  let compressedMap2 = "022111222"

  @Test func compressTest() async throws {
    let challenge = Day09(data: testData)
    let compressed = String(challenge.compressedDriveMap().map { String($0) }.joined(by: ""))
    #expect(compressed == compressedMap)
  }

  @Test func compressTest2() async throws {
    let challenge = Day09(data: testData2)
    let compressed = String(challenge.compressedDriveMap().map { String($0) }.joined(by: ""))
    #expect(compressed == compressedMap2)
  }

  @Test func testPart1() async throws {
    let challenge = Day09(data: testData)
    #expect(String(describing: challenge.part1()) == "1928")
  }

  @Test func testPart2() async throws {
    let challenge = Day09(data: testData)
    #expect(String(describing: challenge.part2()) == "2858")
  }
}
