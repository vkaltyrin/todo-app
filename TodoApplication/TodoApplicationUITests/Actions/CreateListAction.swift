import EarlGrey
import Foundation
import XCTest
@testable import TodoApplication

// Tap `Add` button action
final class CreateListAction: BaseTestAction {

    override func perform() {
        EarlGrey.selectElement(with: grey_accessibilityID(ListDataFlow.AccessibilityIdentifiers.createListButton))
            .perform(grey_tap())
    }
}
