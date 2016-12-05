import Cocoa

private let frequencyKey = "frequency"

class DataStore {

  internal static let userDefaults = UserDefaults.standard

  static var frequency: Int {
    get {
      return userDefaults.integer(forKey: frequencyKey)
    }

    set {
      userDefaults.set(newValue, forKey: frequencyKey)
    }
  }
}
