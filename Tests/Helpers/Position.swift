import Testing

@testable import AdventOfCode

struct PositionTests {

  @Test func offsetFrom() async throws {
    #expect(Position(0, 0).offsetFrom(Position(3, 1)) == (-3, -1))
    #expect(Position(3, 1).offsetFrom(Position(1, 2)) == (2, -1))
    #expect(Position(1, 2).offsetFrom(Position(3, 1)) == (-2, 1))
  }

  @Test func addingOffset() async throws {
    #expect(Position(0, 0).addingOffset((3, 1)) == Position(3, 1))
    #expect(Position(3, 1).addingOffset((-2, 1)) == Position(1, 2))
    #expect(Position(1, 2).addingOffset((2, 3)) == Position(3, 5))
  }

  @Test func subtractingOffset() async throws {
    #expect(Position(0, 0).subtractingOffset((3, 1)) == Position(-3, -1))
    #expect(Position(3, 1).subtractingOffset((2, -1)) == Position(1, 2))
  }
}
