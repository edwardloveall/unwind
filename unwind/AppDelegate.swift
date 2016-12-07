import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var menuController: MenuController?
  var preferencesWindowController: PreferencesWindowController?
  let notifier = Notifier()

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.menuController = MenuController()
    self.preferencesWindowController = PreferencesWindowController()
    if DataStore.frequency == 0 {
      DataStore.frequency = 10
    }
    notifier.setup()
  }

  func applicationWillTerminate(_ aNotification: Notification) {}

  func openPreferences(_ sender: NSMenuItem) {
    let window = preferencesWindowController?.window
    preferencesWindowController?.showWindow(window)
    NSApp.activate(ignoringOtherApps: true)
  }

  func closeApplication(_ sender: NSMenuItem) {
    let app = NSApplication.shared()
    app.terminate(self)
  }
}
