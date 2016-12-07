import Cocoa

class PreferencesViewController: NSViewController {
  @IBOutlet var frequencyField: NSTextField!
  @IBOutlet var messageField: NSTextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    frequencyField.integerValue = DataStore.frequency
    messageField.stringValue = DataStore.message
  }

  @IBAction func changeFrequency(_ sender: NSTextField) {
    DataStore.frequency = sender.integerValue

    let app = NSApplication.shared()
    guard let delegate = app.delegate as? AppDelegate else { return }
    delegate.menuController?.setupTimer()
  }

  @IBAction func changeMessage(_ sender: NSTextField) {
    DataStore.message = sender.stringValue
  }

  @IBAction func terminate(_ sender: NSButton) {
    NSApplication.shared().terminate(self)
  }
}
