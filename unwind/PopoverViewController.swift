import Cocoa

class PopoverViewController: NSViewController {
  @IBOutlet var dismissButton: NSButton!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear() {
    dismissButton.title = DataStore.message
  }

  @IBAction func doneClicked(_ sender: Any) {
    let app = NSApplication.shared()
    guard let delegate = app.delegate as? AppDelegate else { return }
    delegate.menuController?.closePopover(sender)
  }
}
