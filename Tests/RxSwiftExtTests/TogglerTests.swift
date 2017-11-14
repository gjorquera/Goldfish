import XCTest
import RxSwift
import RxSwiftExt
import RxTest

class TogglerTests : XCTestCase {
  var scheduler: TestScheduler?

  override func setUp() {
    scheduler = TestScheduler(initialClock: 0)
  }

  func testTogglerStartingWithTrue() {
    let values = [(), (), (), (), ()]
    let result = toggler(startingWith: true, values)

    let expected = [
      next(200, true as Bool),
      next(200, false),
      next(200, true),
      next(200, false),
      next(200, true),
      completed(200)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testTogglerStartingWithFalse() {
    let values = [(), (), (), (), ()]
    let result = toggler(startingWith: false, values)

    let expected = [
      next(200, false as Bool),
      next(200, true),
      next(200, false),
      next(200, true),
      next(200, false),
      completed(200)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func toggler(startingWith initialValue: Bool, _ values: [Void]) -> TestableObserver<Bool> {
    return scheduler!.start {
      Observable<Void>.from(values).toggler(startingWith: initialValue)
    }
  }
}
