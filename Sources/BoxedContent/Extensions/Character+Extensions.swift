import Foundation

extension Character {
    var terminalWidth: Int {
        guard let scalar = UnicodeScalar(String(self)) else { return 1 }
        return scalar.properties.isEmoji ? 2 : 1
    }
}
