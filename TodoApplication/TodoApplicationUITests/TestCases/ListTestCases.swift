import EarlGrey
import XCTest
import Quick
import Nimble
@testable import TodoApplication

class UITestCase: QuickSpec {
    let navigator: Navigator = NavigatorImpl()
    let matcherFactory: MatcherFactory = MatcherFactoryImpl()
    let actionFactory: ActionFactory = ActionFactoryImpl()
}

final class ListTestCase: UITestCase {
    
    override func spec() {
        beforeSuite {
            let testStorageUtility = TestStorageUtilityImpl()
            testStorageUtility.resetState()
            
            self.navigator.dismissAll()
            self.navigator.openScreen(.lists)
        }
        
        describe("Tap \"Add list\" button") {
            describe("Item") {
                it("Add new item") {
                    // given
                    let name = "Groceries"
                    // when
                    step("Tap \"Add List\" button", self.actionFactory.createListAction())
                    step("Enter list name", self.actionFactory.enterListNameAction(name: name, row: 0))
                    // then
                    EarlGrey.selectElement(with: grey_text(name)).assert(grey_sufficientlyVisible())
                }
                
                it("Edit item") {
                    // given
                    let newName = "Todos"
                    // when
                    step("Tap list", self.actionFactory.openListMenuAction(row: 0))
                    EarlGrey.selectElement(with: grey_text("Edit list 📝")).perform(grey_tap())
                    step("Enter list name", self.actionFactory.enterListNameAction(name: newName, row: 0))
                    // then
                    EarlGrey.selectElement(with: grey_text(newName)).assert(grey_sufficientlyVisible())
                }
            }
        }
    }
}
