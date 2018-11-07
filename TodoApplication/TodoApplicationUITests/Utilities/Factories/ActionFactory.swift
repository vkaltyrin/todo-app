import Foundation
import EarlGrey

protocol ActionFactory: class {
    func createListAction() -> TestActionable
    func enterListNameAction(name: String, row: Int) -> TestActionable
    func openListMenuAction(row: UInt) -> TestActionable
}

final class ActionFactoryImpl: ActionFactory {
    func createListAction() -> TestActionable {
        return CreateListAction()
    }
    
    func enterListNameAction(name: String, row: Int) -> TestActionable {
        return EnterListNameAction(name: name, row: row)
    }
    
    func openListMenuAction(row: UInt) -> TestActionable {
        return OpenListMenuAction(row: row)
    }
}
