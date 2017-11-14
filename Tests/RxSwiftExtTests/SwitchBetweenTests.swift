import XCTest
import RxSwift
import RxSwiftExt
import RxTest

class SwitchBetweenTests : XCTestCase {
  func testSwitchesBetweenObservables() {
    let scheduler = TestScheduler(initialClock: 0)

    let trueCase = {
      scheduler.createColdObservable([
        next(10, 110),
        next(20, 120),
        next(30, 130),
        completed(40)
      ]).asObservable()
    }

    let falseCase = {
      scheduler.createColdObservable([
        next(10, 210),
        next(20, 220),
        next(30, 230),
        completed(40)
      ]).asObservable()
    }

    let toggler = scheduler.createColdObservable([
      next(0, true),
      next(25, false),
      next(60, true),
      completed(75)
    ])

    let result = scheduler.start {
      toggler.switchBetween(trueCase, falseCase)
    }

    let expected = [
      next(210, 110),
      next(220, 120),
      next(235, 210),
      next(245, 220),
      next(255, 230),
      next(270, 110),
      next(280, 120),
      next(290, 130),
      completed(300)
    ]

    XCTAssertEqual(result.events, expected)
  }
}
