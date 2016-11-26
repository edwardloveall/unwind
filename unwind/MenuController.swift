import Cocoa

class MenuController: NSObject {
  let statusItem: NSStatusItem
  let popover = NSPopover()

  override init() {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem.image = NSImage(named: "temp-icon")
    popover.contentViewController = PopoverViewController()

    super.init()

    if let button = statusItem.button {
      button.target = self
      button.action = #selector(togglePopover(_:))
    }
  }

  func togglePopover(_ sender: Any?) {
    if popover.isShown {
      closePopover(sender)
    } else {
      showPopover(sender)
    }
  }

  func closePopover(_ sender: Any?) {
    popover.performClose(sender)
  }

  func showPopover(_ sender: Any?) {
    guard let button = statusItem.button else { return }
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
  }
}
