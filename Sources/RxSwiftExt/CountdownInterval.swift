import RxSwift

extension ObservableType where E: RxAbstractInteger {
  /**
   * Returns an observable sequence that counts down from a specified interval.
   *
   * The sequence will count down starting from the given interval every given
   * period running a timer on the given scheduler.
   */
  public static func countdownInterval(_ interval: E,
      period: RxTimeInterval = 1.0,
      scheduler: SchedulerType = MainScheduler.instance)
      -> Observable<E> {
    return Observable<E>.interval(period, scheduler: scheduler)
        .startWith(-1)
        .map { interval - ($0 + 1) }
        .takeWhile { $0 >= 0 }
  }
}
