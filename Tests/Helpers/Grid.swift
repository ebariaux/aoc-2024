import Testing

@testable import AdventOfCode

struct GridTests {

  @Test func init1() async throws {
    let grid = Grid(
      data: """
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
        """)

    #expect(grid.width == 10)
    #expect(grid.height == 10)
    #expect(grid.elementAt(0, 0) == "M")
    #expect(grid.elementAt(5, 0) == "X")
    #expect(grid.elementAt(1, 5) == "X")
    #expect(grid.elementAt(10, 0) == nil)
    #expect(grid.elementAt(0, 10) == nil)
  }

  @Test func init2() async throws {
    let grid = Grid(
      data: """
        ABC
        DEF
        """)
    #expect(grid.width == 3)
    #expect(grid.height == 2)
    #expect(grid.elementAt(0, 0) == "A")
    #expect(grid.elementAt(2, 0) == "C")
    #expect(grid.elementAt(2, 1) == "F")
    #expect(grid.elementAt(3, 0) == nil)
    #expect(grid.elementAt(0, 2) == nil)
  }
}
