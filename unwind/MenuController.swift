import Cocoa

class MenuController: NSObject {
  let statusItem: NSStatusItem
  let interrupter = NSPopover()
  var timer = Timer()

  override init() {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem.image = NSImage(named: "temp-icon")
    interrupter.contentViewController = PopoverViewController()

    super.init()

    setupMenu()
    setupTimer()
  }

  func setupMenu() {
    let menu = NSMenu()
    let prefs = NSMenuItem(title: "Preferences...",
                           action: #selector(AppDelegate.openPreferences(_:)),
                           keyEquivalent: ",")
    menu.addItem(prefs)

    statusItem.menu = menu
  }

  func setupTimer() {
    let frequency = DataStore.frequency
    let interval = TimeInterval(frequency * 60)
    let runLoop = RunLoop.current

    timer.invalidate()
    timer = Timer(timeInterval: interval,
                  target: self,
                  selector: #selector(showPopover),
                  userInfo: nil,
                  repeats: false)
    runLoop.add(timer, forMode: .commonModes)
    runLoop.add(timer, forMode: .eventTrackingRunLoopMode)
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
