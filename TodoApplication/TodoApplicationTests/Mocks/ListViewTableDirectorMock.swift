@testable import TodoApplication
import XCTest

final class ListViewTableDirectorMock: NSObject, ListViewTableDirector {

    var invokedItemsSetter = false
    var invokedItemsSetterCount = 0
    var invokedItems: [ListViewModel]?
    var invokedItemsList = [[ListViewModel]]()
    var invokedItemsGetter = false
    var invokedItemsGetterCount = 0
    var stubbedItems: [ListViewModel]! = []
    var items: [ListViewModel] {
        set {
            invokedItemsSetter = true
            invokedItemsSetterCount += 1
            invokedItems = newValue
            invokedItemsList.append(newValue)
        }
        get {
            invokedItemsGetter = true
            invokedItemsGetterCount += 1
            return stubbedItems
        }
    }
    var invokedOnListTapSetter = false
    var invokedOnListTapSetterCount = 0
    var invokedOnListTap: ((ListViewModel) -> ())?
    var invokedOnListTapList = [((ListViewModel) -> ())?]()
    var invokedOnListTapGetter = false
    var invokedOnListTapGetterCount = 0
    var stubbedOnListTap: ((ListViewModel) -> ())!
    var onListTap: ((ListViewModel) -> ())? {
        set {
            invokedOnListTapSetter = true
            invokedOnListTapSetterCount += 1
            invokedOnListTap = newValue
            invokedOnListTapList.append(newValue)
        }
        get {
            invokedOnListTapGetter = true
            invokedOnListTapGetterCount += 1
            return stubbedOnListTap
        }
    }
    var invokedOnCellTextDidEndEditingSetter = false
    var invokedOnCellTextDidEndEditingSetterCount = 0
    var invokedOnCellTextDidEndEditing: ((Identifier, String) -> ())?
    var invokedOnCellTextDidEndEditingList = [((Identifier, String) -> ())?]()
    var invokedOnCellTextDidEndEditingGetter = false
    var invokedOnCellTextDidEndEditingGetterCount = 0
    var stubbedOnCellTextDidEndEditing: ((Identifier, String) -> ())!
    var onCellTextDidEndEditing: ((Identifier, String) -> ())? {
        set {
            invokedOnCellTextDidEndEditingSetter = true
            invokedOnCellTextDidEndEditingSetterCount += 1
            invokedOnCellTextDidEndEditing = newValue
            invokedOnCellTextDidEndEditingList.append(newValue)
        }
        get {
            invokedOnCellTextDidEndEditingGetter = true
            invokedOnCellTextDidEndEditingGetterCount += 1
            return stubbedOnCellTextDidEndEditing
        }
    }
    var invokedOnDeleteTapSetter = false
    var invokedOnDeleteTapSetterCount = 0
    var invokedOnDeleteTap: ((Identifier) -> ())?
    var invokedOnDeleteTapList = [((Identifier) -> ())?]()
    var invokedOnDeleteTapGetter = false
    var invokedOnDeleteTapGetterCount = 0
    var stubbedOnDeleteTap: ((Identifier) -> ())!
    var onDeleteTap: ((Identifier) -> ())? {
        set {
            invokedOnDeleteTapSetter = true
            invokedOnDeleteTapSetterCount += 1
            invokedOnDeleteTap = newValue
            invokedOnDeleteTapList.append(newValue)
        }
        get {
            invokedOnDeleteTapGetter = true
            invokedOnDeleteTapGetterCount += 1
            return stubbedOnDeleteTap
        }
    }
    var invokedFocusOnList = false
    var invokedFocusOnListCount = 0
    var invokedFocusOnListParameters: (identifier: Identifier, Void)?
    var invokedFocusOnListParametersList = [(identifier: Identifier, Void)]()

    func focusOnList(_ identifier: Identifier) {
        invokedFocusOnList = true
        invokedFocusOnListCount += 1
        invokedFocusOnListParameters = (identifier, ())
        invokedFocusOnListParametersList.append((identifier, ()))
    }

    var invokedSetup = false
    var invokedSetupCount = 0
    var invokedSetupParameters: (tableView: UITableView, Void)?
    var invokedSetupParametersList = [(tableView: UITableView, Void)]()

    func setup(with tableView: UITableView) {
        invokedSetup = true
        invokedSetupCount += 1
        invokedSetupParameters = (tableView, ())
        invokedSetupParametersList.append((tableView, ()))
    }
}
