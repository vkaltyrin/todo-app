import UIKit

extension UIAccessibilityIdentification {
    var qaAccessibilityIdentifier: String? {
        set {
            self.accessibilityIdentifier = newValue
            if let element = self as? NSObject {
                element.isAccessibilityElement = true
            }
        }
        get {
            return self.accessibilityIdentifier
        }
    }
}
