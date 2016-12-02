import Cocoa

class PreferencesViewController: NSViewController {
  @IBOutlet var frequencyField: NSTextField!

  var menuController: MenuController?
  override var acceptsFirstResponder: Bool {
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    frequencyField.integerValue = 10
  }

  @IBAction func changeFrequency(_ sender: NSTextField) {
    menuController?.setFrequency(frequency: sender.integerValue)
    menuController?.setupTimer()
  }

  @IBAction func terminate(_ sender: NSButton) {
    NSApplication.shared().terminate(self)
  }
}
