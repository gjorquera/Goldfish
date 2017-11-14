import Foundation

public class Clock {
  /**
   * Returns the time in seconds represented as a clock label.
   *
   * For example:
   *     17*60 + 23 seconds => "17:23"
   */
  public static func label(time: Int) -> String {
    let minutes = String(format: "%02d", time / 60)
    let seconds = String(format: "%02d", time % 60)
    return "\(minutes):\(seconds)"
  }
}
