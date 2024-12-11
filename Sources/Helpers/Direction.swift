enum Direction: String, CaseIterable {
  case up = "^"
  case down = "v"
  case left = "<"
  case right = ">"

  var offset: (Int, Int) {
    switch self {
    case .up: return (0, -1)
    case .down: return (0, 1)
    case .left: return (-1, 0)
    case .right: return (1, 0)
    }
  }
}
