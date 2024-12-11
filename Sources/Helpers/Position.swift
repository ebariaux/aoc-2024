struct Position: Hashable {
  var x: Int
  var y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  func offsetFrom(_ position: Position) -> (Int, Int) {
    (x - position.x, y - position.y)
  }

  func addingOffset(_ offset: (Int, Int)) -> Position {
    Position(x + offset.0, y + offset.1)
  }

  func subtractingOffset(_ offset: (Int, Int)) -> Position {
    Position(x - offset.0, y - offset.1)
  }

  func moving(_ direction: Direction) -> Position {
    self.addingOffset(direction.offset)
  }
}
