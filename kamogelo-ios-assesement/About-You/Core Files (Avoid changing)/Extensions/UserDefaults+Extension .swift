import Foundation

extension UserDefaults {
    private enum Keys {
        static let didStartAssignment = "didStartAssignment"
    }

    static var didStartAssignment: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.didStartAssignment)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.didStartAssignment)
        }
    }
}

extension UserDefaults {
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
