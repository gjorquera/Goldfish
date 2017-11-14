import RxSwift

extension ObservableType where E == Void {
  /**
   * For each element, toggles between true and false.
   *
   * Works only for Observable<Bool>, starting with the initialValue it toggles
   * between true and false whenever there's a new element.
   */
  public func toggler(startingWith initialValue: Bool) -> Observable<Bool> {
    return self.asObservable()
        .scan(!initialValue, accumulator: { acc, curr in !acc })
  }
}
