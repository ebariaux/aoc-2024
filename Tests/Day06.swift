import Testing

@testable import AdventOfCode

struct Day06Tests {
  // Smoke test data provided in the challenge question
  static let testData = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  static let testData2 = """
    ....#.....
    .....#...#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  static let testDataLooping = """
    ....#.....
    .....#...#
    ..........
    ..#.......
    .......#..
    ..........
    .#.#^.....
    ....#...#.    
    """

  static let testDataLooping2 = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#.#^.....
    ........#.
    #.........
    ......#...
    """

  static let testDataLooping3 = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ......#.#.
    #.........
    ......#...
    """

  static let testDataLooping4 = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #..#......
    ......#...
    """

  @Test(
    "Detect there's a loop in map where there is one",
    arguments: [testDataLooping, testDataLooping2, testDataLooping3, testDataLooping4])
  func testLooping(data: String) async throws {
    let challenge = Day06(data: data)
    var map = challenge.map
    let looping = map.isLooping()
    #expect(looping)
  }

  @Test("Detect there's no loop in map where there is none", arguments: [testData, testData2])
  func testNonLooping(data: String) async throws {
    let challenge = Day06(data: data)
    var map = challenge.map
    let looping = map.isLooping()
    #expect(!looping)
  }

  @Test func testPart1() async throws {
    let challenge = Day06(data: Self.testData)
    #expect(String(describing: challenge.part1()) == "41")
  }

  @Test func testPart2() async throws {
    let challenge = Day06(data: Self.testData)
    #expect(String(describing: challenge.part2()) == "6")
  }
}