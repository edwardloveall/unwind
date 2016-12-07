import Cocoa

private let frequencyKey = "frequency"
private let messageKey = "message"

class DataStore {

  internal static let userDefaults = UserDefaults.standard

  static var frequency: Int {
    get { return userDefaults.integer(forKey: frequencyKey) }
    set { userDefaults.set(newValue, forKey: frequencyKey) }
  }

  static var message: String {
    get { return userDefaults.string(forKey: messageKey) ?? "Dismiss" }
    set { userDefaults.set(newValue, forKey: messageKey) }
  }
}
