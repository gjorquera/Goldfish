import XCTest

@testable import GoldfishCore

class ClockTests : XCTestCase {
  func testLabel() {
    XCTAssertEqual("25:00", Clock.label(time: 25*60))
    XCTAssertEqual("17:23", Clock.label(time: 17*60 + 23))
    XCTAssertEqual("07:03", Clock.label(time: 7*60 + 3))
    XCTAssertEqual("00:00", Clock.label(time: 0))
  }
}
