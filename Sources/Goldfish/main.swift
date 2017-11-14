import Cocoa
import GoldfishCore

class GoldfishApp : NSObject, NSApplicationDelegate {
  let systemBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
  let menu = NSMenu()
  let startStop = NSMenuItem(title: "Start", action: #selector(startStopAction(_:)), keyEquivalent: "")
  let quit = NSMenuItem(title: "Quit", action: #selector(quitAction(_:)), keyEquivalent: "")

  let pomodoro = Pomodoro(startTime: 25*60, hintTime: 5*60)

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    systemBar.menu = menu
    menu.addItem(startStop)
    menu.addItem(NSMenuItem.separator())
    menu.addItem(quit)

    pomodoro.onToggle { self.startStop.title = $0 ? "Stop" : "Start" }
    pomodoro.onTimer { self.systemBar.title = Clock.label(time: $0) }
  }

  @objc func startStopAction(_ sender: NSMenuItem) {
    pomodoro.toggle()
  }

  @objc func quitAction(_ sender: NSMenuItem) {
    NSApp.terminate(self)
  }
}

let app = NSApplication.shared
app.setActivationPolicy(.accessory)
app.delegate = GoldfishApp()
app.run()
