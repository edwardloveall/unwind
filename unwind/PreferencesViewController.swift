import Cocoa

class PreferencesViewController: NSViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func closeApp(_ sender: NSButton) {
    NSApplication.shared().terminate(sender)
  }
}
