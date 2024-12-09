struct Grid {
  var elements: [[String]]
  var width: Int
  var height: Int

  init(data: String) {
    elements = data.split(separator: "\n").map {
      $0.split(separator: "").compactMap {
        String($0)
      }
    }
    width = elements.first?.count ?? 0
    height = elements.count
  }

  subscript(x: Int, y: Int) -> String {
    get {
      assert(isWithinGrid(x, y), "Index out of range")
      return elements[y][x]
    }
    set {
      assert(isWithinGrid(x, y), "Index out of range")
      elements[y][x] = newValue
    }
  }

  subscript(position: Position) -> String {
    get {
      assert(isWithinGrid(position), "Index out of range")
      return elements[position.y][position.x]
    }
    set {
      assert(isWithinGrid(position), "Index out of range")
      elements[position.y][position.x] = newValue
    }
  }

  func elementAt(_ x: Int, _ y: Int) -> String? {
    guard isWithinGrid(x, y) else { return nil }
    return elements[y][x]
  }

  func elementAt(_ position: Position) -> String? {
    guard isWithinGrid(position) else { return nil }
    return elements[position.y][position.x]
  }

  func iterateOverGridElements(_ body: (Position, String) -> Void) {
    for y in 0..<height {
      for x in 0..<width {
        body(Position(x, y), elements[y][x])
      }
    }
  }

  func isWithinGrid(_ position: Position) -> Bool {
    isWithinGrid(position.x, position.y)
  }

  func isWithinGrid(_ x: Int, _ y: Int) -> Bool {
    x >= 0 && x < width && y >= 0 && y < height
  }

  func printGrid() {
    for y in 0..<height {
      for x in 0..<width {
        print(elements[y][x], terminator: "")
      }
      print()
    }
    print()
  }
}
