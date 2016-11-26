import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var menuController: MenuController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.menuController = MenuController()
  }

  func applicationWillTerminate(_ aNotification: Notification) {}
}
