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
    var invokedOnCellTextDidEndEditing: ((ListViewModel) -> ())?
    var invokedOnCellTextDidEndEditingList = [((ListViewModel) -> ())?]()
    var invokedOnCellTextDidEndEditingGetter = false
    var invokedOnCellTextDidEndEditingGetterCount = 0
    var stubbedOnCellTextDidEndEditing: ((ListViewModel) -> ())!
    var onCellTextDidEndEditing: ((ListViewModel) -> ())? {
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
    var invokedFocusOnCell = false
    var invokedFocusOnCellCount = 0
    var invokedFocusOnCellParameters: (identifier: Identifier, Void)?
    var invokedFocusOnCellParametersList = [(identifier: Identifier, Void)]()

    func focusOnCell(_ identifier: Identifier) {
        invokedFocusOnCell = true
        invokedFocusOnCellCount += 1
        invokedFocusOnCellParameters = (identifier, ())
        invokedFocusOnCellParametersList.append((identifier, ()))
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
