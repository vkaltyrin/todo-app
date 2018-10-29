import EarlGrey
import Foundation
import XCTest
@testable import TodoApplication

final class EnterListNameAction: BaseTestAction {
    
    private let name: String
    private let row: Int
    
    init(name: String, row: Int) {
        self.name = name
        self.row = row
    }
    
    override func perform() {
        let accessibilityIdentifier = CellAccessibilityIdentifierBuilder.build(
            identifier: ListDataFlow.AccessibilityIdentifiers.listTextField,
            index: row
        )
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityIdentifier))
            .perform(grey_typeText(name))
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityIdentifier))
            .perform(grey_typeText("\n"))
    }
}
