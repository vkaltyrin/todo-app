import Foundation
import EarlGrey
import XCTest
@testable import TodoApplication

class CreateNewListTestCase: BaseTestCase {
    
    enum TestData {
        static let listName = "Tasks for tomorrow"
    }

    override func setUp() {
        super.setUp()

        precondition("Open lists screen") {
            NavigatorImpl().openScreen(.lists)
        }
    }

    func test() {
        step("Tap to the `Add` button") {
            CreateListAction().perform()
        }

        assert("Keyboard is shown on the screen") { () -> (Bool) in
            TestUtils.waitForKeyboardToAppear()
        }

        step("Input text") {
            EnterListNameAction(name: TestData.listName, row: 0).perform()
        }
        
        expect("Text is shown on the screen correctly") {
            let accessibilityIdentifier = ListDataFlow.AccessibilityIdentifiers.listTextField(0)
            TestUtils.retrieveText(accessibilityIdentifier: accessibilityIdentifier) { text in
                XCTAssertEqual(text, TestData.listName)
            }
        }
        
    }
}
