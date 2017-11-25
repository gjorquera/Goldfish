import RxSwift
import RxSwiftExt

/**
 * Represents a Pomodoro timer.
 *
 * When a Pomodoro timer is created, it starts stopped. Regardless of how much
 * time it passes, none of it's callbacks will be called.
 *
 * Whenever you toggle it, Pomodoro will go from stopped to started and to back
 * to stopped. The onToggle event is emitted every time the Pomodoro is toggled.
 *
 * When the Pomodoro is started, it emits the onTimer event on each timer
 * update.
 *
 * If the Pomodoro finishes, it emits the onFinished event and toggles the
 * Pomodoro back to stopped.
 */
public class Pomodoro {
  let inputStream = PublishSubject<Void>()

  let toggler: Observable<Bool>
  let timer: Observable<Int>
  let hint: Observable<Void>
  let finished: Observable<Void>

  public init(startTime: Int, hintTime: Int, scheduler: SchedulerType = MainScheduler.instance) {
    self.toggler = self.inputStream.startWith(()).toggler(startingWith: false)

    let countdownInterval = { Observable.countdownInterval(startTime - 1, scheduler: scheduler) }
    let stoppedInterval = { Observable.just(startTime) }
    self.timer = self.toggler.switchBetween(countdownInterval, stoppedInterval)

    self.hint = self.timer.filter { $0 == hintTime }.map { _ in () }
    self.finished = self.timer.filter { $0 == 0 }.map { _ in () }.share(replay: 1)

    _ = self.finished.subscribe(onNext: toggle)
  }

  public func toggle() {
    self.inputStream.onNext(())
  }

  public func onToggle(_ callback: @escaping (Bool) -> ()) {
    _ = self.toggler.subscribe(onNext: callback)
  }

  public func onTimer(_ callback: @escaping (Int) -> ()) {
    _ = self.timer.subscribe(onNext: callback)
  }

  public func onHint(_ callback: @escaping () -> ()) {
    _ = self.hint.subscribe(onNext: callback)
  }

  public func onFinished(_ callback: @escaping () -> ()) {
    _ = self.finished.subscribe(onNext: callback)
  }
}
