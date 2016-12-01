import Cocoa

class MenuController: NSObject {
  let statusItem: NSStatusItem
  let interrupter = NSPopover()
  let preferences = NSWindow()
  var timer = Timer()

  override init() {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem.image = NSImage(named: "temp-icon")
    interrupter.contentViewController = PopoverViewController()

    super.init()

    if let button = statusItem.button {
      button.target = self
      button.action = #selector(togglePreferences(_:))
    }

    setupTimer()
  }

  func setupTimer() {
    let tenMinutes = TimeInterval(10 * 60)
    let runLoop = RunLoop.current

    timer.invalidate()
    timer = Timer(timeInterval: tenMinutes,
                  target: self,
                  selector: #selector(showPopover),
                  userInfo: nil,
                  repeats: false)
    runLoop.add(timer, forMode: .commonModes)
    runLoop.add(timer, forMode: .eventTrackingRunLoopMode)
  }

  func togglePreferences(_ sender: Any?) {
    guard
      let button = statusItem.button,
      let window = button.window
    else { return }
    preferences.contentViewController = PreferencesViewController()
    let buttonFrame = window.frame
    let origin = NSPoint(x: buttonFrame.minX,
                         y: buttonFrame.maxY)
    preferences.setFrameOrigin(origin)
    preferences.makeKeyAndOrderFront(sender)
  }

  func togglePopover(_ sender: Any?) {
    if interrupter.isShown {
      closePopover(sender)
    } else {
      showPopover()
    }
  }

  @IBAction func closePopover(_ sender: Any?) {
    interrupter.performClose(sender)
    activatePreviousApp()
    setupTimer()
  }

  func showPopover() {
    guard let button = statusItem.button else { return }
    interrupter.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
  }

  func activatePreviousApp() {
    let workspace = NSWorkspace.shared()
    if let app = workspace.menuBarOwningApplication {
      app.activate(options: [])
    }
  }
}
