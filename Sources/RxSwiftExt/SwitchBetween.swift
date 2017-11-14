import RxSwift

extension ObservableType where E == Bool {
  /**
   * Switches between two observable sequences given the value of each element.
   *
   * Whenever a new element is emitted, depending on it's value, a new
   * observable sequence will be created depending on the emitted value. If it's
   * true, a new trueCase observable value will start, falseCase otherwise.
   */
  public func switchBetween<R>(_ trueCase: @escaping () -> Observable<R>,
      _ falseCase: @escaping () -> Observable<R>)
      -> Observable<R> {
    return self.asObservable()
        .map { $0 ? trueCase() : falseCase() }
        .switchLatest()
  }
}
