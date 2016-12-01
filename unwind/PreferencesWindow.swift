import Cocoa

class PreferencesWindow: NSWindow {
  override var styleMask: NSWindowStyleMask {
    get {
      return .borderless
    }
    set {
      super.styleMask = newValue
    }
  }
}
