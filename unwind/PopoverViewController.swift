import Cocoa

class PopoverViewController: NSViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func doneClicked(_ sender: Any) {
    let app = NSApplication.shared()
    guard let delegate = app.delegate as? AppDelegate else { return }
    delegate.menuController?.closePopover(sender)
  }
}
