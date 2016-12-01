import Cocoa

class MenuController: NSObject {
  let statusItem: NSStatusItem
  let interrupter = NSPopover()
  let preferences = PreferencesViewController()
  var timer = Timer()

  override init() {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem.image = NSImage(named: "temp-icon")
    interrupter.contentViewController = PopoverViewController()

    super.init()

    setupPreferencesMenu()
    setupTimer()
  }

  func setupPreferencesMenu() {
    let menu = NSMenu()
    let prefs = NSMenuItem()
    prefs.view = preferences.view

    let separator = NSMenuItem.separator()
    let quit = NSMenuItem(title: "Quit Unwind",
                          action: #selector(terminate(_:)),
                          keyEquivalent: "q")

    menu.addItem(prefs)
    menu.addItem(separator)
    menu.addItem(quit)

    statusItem.menu = menu
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

  func terminate(_ sender: Any?) {
    NSApplication.shared().terminate(self)
  }
}
