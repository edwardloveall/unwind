import Cocoa

class Notifier: NSObject {
  var notificationCenter: NotificationCenter {
    return NSWorkspace.shared().notificationCenter
  }

  override init() {
    super.init()
  }

  func setup() {
    setupWakeNotification()
  }

  func setupWakeNotification() {
    notificationCenter.addObserver(self,
                                   selector: #selector(computerDidWake(notification:)),
                                   name: NSNotification.Name.NSWorkspaceDidWake,
                                   object: nil)
  }

  func computerDidWake(notification: NSNotification) {
    let app = NSApplication.shared()
    guard let delegate = app.delegate as? AppDelegate else { return }
    delegate.menuController?.setupTimer()
  }

  deinit {
    notificationCenter.removeObserver(self)
  }
}
