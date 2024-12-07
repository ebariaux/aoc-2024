import Foundation

protocol Operator: CaseIterable {
  func evaluate(_ lhs: Int, _ rhs: Int) -> Int
}

enum SimpleOperator: Operator {
  case add
  case multiply

  func evaluate(_ lhs: Int, _ rhs: Int) -> Int {
    switch self {
    case .add: return lhs + rhs
    case .multiply: return lhs * rhs
    }
  }
}

enum ExtendedOperator: Operator {
  case add
  case multiply
  case concat

  func evaluate(_ lhs: Int, _ rhs: Int) -> Int {
    switch self {
    case .add: return lhs + rhs
    case .multiply: return lhs * rhs
    case .concat: return Int(String(lhs) + String(rhs))!
    }
  }
}

struct Equation {
  let result: Int
  let operands: [Int]

  func evaluate(operators: [some Operator]) -> Int {
    guard !operands.isEmpty else { return 0 }
    guard operators.count == operands.count - 1 else { return 0 }

    // tuple (result, index of operand to execute)
    return operands.reduce((0, -1)) { result, operand in
      guard result.1 >= 0 else { return (operand, result.1 + 1) }
      return (operators[result.1].evaluate(result.0, operand), result.1 + 1)
    }.0
  }

  func isValidFor(operators: [some Operator]) -> Bool {
    result == evaluate(operators: operators)
  }

  func generatePossibleOperatorsSequence<T: Operator>(length: Int, type: T.Type) -> [[T]] {
    if length == 1 {
      return T.allCases.map { [$0] }
    }

    var result: [[T]] = []

    for ops in generatePossibleOperatorsSequence(length: length - 1, type: type) {
      for op in T.allCases {
        result.append(ops + [op])
      }
    }
    return result
  }

  /// Find a sequence of operators that make the equation valid = operands evaluated with the operators = result
  func findOperators<T: Operator>(type: T.Type) -> [T]? {
    for ops in generatePossibleOperatorsSequence(length: operands.count - 1, type: type) {
      if isValidFor(operators: ops) {
        return ops
      }
    }
    return nil
  }
}

struct Day07: AdventDay {
  var data: String
  var equations: [Equation]

  init(data: String) {
    self.data = data
    let lines = data.split(separator: "\n")
    equations = lines.map {
      let temp = $0.split(separator: ":")
      return Equation(
        result: Int(temp[0])!, operands: temp[1].split(separator: " ").compactMap { Int($0) })
    }
  }

  func part1() -> Any {
    equations.filter { $0.findOperators(type: SimpleOperator.self) != nil }.reduce(0) {
      $0 + $1.result
    }
  }

  func part2() -> Any {
    equations.filter { $0.findOperators(type: ExtendedOperator.self) != nil }.reduce(0) {
      $0 + $1.result
    }
  }
}
