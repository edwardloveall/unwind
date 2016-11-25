import Cocoa

class MenuController {
  let statusItem: NSStatusItem
  let popOver = NSPopover()

  init() {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem.image = NSImage(named: "temp-icon")
    if let button = statusItem.button {
      button.action = #selector(MenuController.togglePopover)
    }
    popOver.contentViewController = PopoverViewController()
  }

  @objc func togglePopover(_ sender: Any?) {
    guard let button = statusItem.button else { return }

    if popOver.isShown {
      popOver.performClose(sender)
    } else {
      popOver.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
  }
}
