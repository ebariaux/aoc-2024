import Testing

@testable import AdventOfCode

struct Day07Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

  @Test func operators() async throws {
    #expect(SimpleOperator.add.evaluate(6, 7) == 13)
    #expect(SimpleOperator.multiply.evaluate(6, 7) == 42)
  }

  @Test func evaluateEquation() async throws {
    let equation = Equation(result: 0, operands: [1, 2, 3, 4])
    #expect(
      equation.evaluate(operators: [SimpleOperator.add, SimpleOperator.add, SimpleOperator.add])
        == 10)
    #expect(
      equation.evaluate(operators: [
        SimpleOperator.add, SimpleOperator.multiply, SimpleOperator.add,
      ]) == 13)
    #expect(
      equation.evaluate(operators: [
        SimpleOperator.multiply, SimpleOperator.add, SimpleOperator.multiply,
      ]) == 20)
  }

  @Test func testPart1() async throws {
    let challenge = Day07(data: testData)
    #expect(String(describing: challenge.part1()) == "3749")
  }

  @Test func testPart2() async throws {
    let challenge = Day07(data: testData)
    #expect(String(describing: challenge.part2()) == "11387")
  }
}
