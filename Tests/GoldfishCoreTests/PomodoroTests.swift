import XCTest
import RxSwift
import RxTest

@testable import GoldfishCore

class PomodoroTests : XCTestCase {
  var scheduler: TestScheduler?
  var pomodoro: Pomodoro?

  override func setUp() {
    scheduler = TestScheduler(initialClock: 0)
  }

  func testInitOnlyEmitsStartTime() {
    let result = pomodoro(startTime: 5, { self.pomodoro!.timer })

    let expected = [
      next(200, 5 as Int)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testToggleStartsAndStopsTheTimer() {
    toggleAt(210)
    toggleAt(212)

    let result = pomodoro(startTime: 5, { self.pomodoro!.timer })

    let expected = [
      next(200, 5 as Int),
      next(210, 4),
      next(211, 3),
      next(212, 5)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testFinishedPomodoroResetsToStartTime() {
    toggleAt(210)

    let result = pomodoro(startTime: 3, { self.pomodoro!.timer })

    let expected = [
      next(200, 3 as Int),
      next(210, 2),
      next(211, 1),
      next(212, 3)
    ]

    XCTAssertEqual(result.events, expected)
  }

  func testFinishedPomodoroGetsToggled() {
    toggleAt(210)

    let result = pomodoro(startTime: 3, { self.pomodoro!.toggler })

    let expected = [
      next(200, false as Bool),
      next(210, true as Bool),
      next(212, false as Bool)
    ]

    XCTAssertEqual(result.events, expected)
  }

  private func pomodoro<E>(startTime: Int, _ create: @escaping () -> Observable<E>) -> TestableObserver<E> {
    pomodoro = Pomodoro(startTime: startTime, hintTime: 1, scheduler: scheduler!)
    return scheduler!.start(create)
  }

  private func toggleAt(_ time: Int) {
    scheduler!.scheduleAt(time, action: { self.pomodoro!.toggle() })
  }
}
