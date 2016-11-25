import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
  let popOver = NSPopover()

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItem.image = NSImage(named: "temp-icon")
    if let button = statusItem.button {
      button.action = #selector(AppDelegate.togglePopover)
    }
    popOver.contentViewController = PopoverViewController()
  }

  func togglePopover(_ sender: Any?) {
    guard let button = statusItem.button else { return }

    if popOver.isShown {
      popOver.performClose(sender)
    } else {
      popOver.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
  }

  func applicationWillTerminate(_ aNotification: Notification) {}
}
