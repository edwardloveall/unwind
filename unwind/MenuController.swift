import Cocoa

class MenuController: NSObject {
  let statusItem: NSStatusItem
  let popover = NSPopover()
  var timer = Timer()

  override init() {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem.image = NSImage(named: "temp-icon")
    popover.contentViewController = PopoverViewController()

    super.init()

    if let button = statusItem.button {
      button.target = self
      button.action = #selector(togglePopover(_:))
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

  func togglePopover(_ sender: Any?) {
    if popover.isShown {
      closePopover(sender)
    } else {
      showPopover()
    }
  }

  @IBAction func closePopover(_ sender: Any?) {
    popover.performClose(sender)
    activatePreviousApp()
    setupTimer()
  }

  func showPopover() {
    guard let button = statusItem.button else { return }
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
  }

  func activatePreviousApp() {
    let workspace = NSWorkspace.shared()
    if let app = workspace.menuBarOwningApplication {
      app.activate(options: [])
    }
  }
}
