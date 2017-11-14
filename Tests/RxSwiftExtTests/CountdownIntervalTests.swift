import XCTest
import RxSwift
import RxSwiftExt
import RxTest

class CountdownIntervalTests : XCTestCase {
  var scheduler: TestScheduler?

  override func setUp() {
    scheduler = TestScheduler(initialClock: 0)
  }

  func testPositiveIntervalCountsdownFromInterval() {
    let result = countdownInterval(5)

    let expected = [
      next(200, 5 as Int),
      next(201, 4),
      next(202, 3),
      next(203, 2),
      next(204, 1),
      next(205, 0),
      completed(206)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testOneIntervalStopsAfterTwoTicks() {
    let result = countdownInterval(1)

    let expected = [
      next(200, 1 as Int),
      next(201, 0),
      completed(202)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testZeroIntervalStopsAfterOneTick() {
    let result = countdownInterval(0)

    let expected = [
      next(200, 0 as Int),
      completed(201)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testNegativeIntervalStopsAfterOneTick() {
    let result = countdownInterval(-3)

    let expected: [Recorded<Event<Int>>] = [
      completed(200)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func countdownInterval(_ interval: Int) -> TestableObserver<Int> {
    return scheduler!.start {
      Observable<Int>.countdownInterval(interval, period: 1.0, scheduler: self.scheduler!)
    }
  }
}
