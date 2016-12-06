import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var menuController: MenuController?
  var preferencesWindowController: PreferencesWindowController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.menuController = MenuController()
    self.preferencesWindowController = PreferencesWindowController()
    if DataStore.frequency == 0 {
      DataStore.frequency = 10
    }
  }

  func applicationWillTerminate(_ aNotification: Notification) {}

  @IBAction func openPreferences(_ sender: NSMenuItem) {
    let window = preferencesWindowController?.window
    preferencesWindowController?.showWindow(window)
  }
}
