import UIKit

protocol AccessibleCell {
    func setAccessibilityIdentifierIndex(index: Int)
}

final class CellAccessibilityIdentifierBuilder {
    class func build(identifier: String, index: Int) -> String {
        return "\(identifier)\(index)"
    }
}
