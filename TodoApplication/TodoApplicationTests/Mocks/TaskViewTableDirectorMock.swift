@testable import TodoApplication
import XCTest

final class TaskViewTableDirectorMock: NSObject, TaskViewTableDirector {

    var invokedItemsSetter = false
    var invokedItemsSetterCount = 0
    var invokedItems: [TaskViewModel]?
    var invokedItemsList = [[TaskViewModel]]()
    var invokedItemsGetter = false
    var invokedItemsGetterCount = 0
    var stubbedItems: [TaskViewModel]! = []
    var items: [TaskViewModel] {
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
    var invokedOnTaskTapSetter = false
    var invokedOnTaskTapSetterCount = 0
    var invokedOnTaskTap: ((Identifier) -> ())?
    var invokedOnTaskTapList = [((Identifier) -> ())?]()
    var invokedOnTaskTapGetter = false
    var invokedOnTaskTapGetterCount = 0
    var stubbedOnTaskTap: ((Identifier) -> ())!
    var onTaskTap: ((Identifier) -> ())? {
        set {
            invokedOnTaskTapSetter = true
            invokedOnTaskTapSetterCount += 1
            invokedOnTaskTap = newValue
            invokedOnTaskTapList.append(newValue)
        }
        get {
            invokedOnTaskTapGetter = true
            invokedOnTaskTapGetterCount += 1
            return stubbedOnTaskTap
        }
    }
    var invokedOnCellTextDidEndEditingSetter = false
    var invokedOnCellTextDidEndEditingSetterCount = 0
    var invokedOnCellTextDidEndEditing: ((TaskViewModel) -> ())?
    var invokedOnCellTextDidEndEditingList = [((TaskViewModel) -> ())?]()
    var invokedOnCellTextDidEndEditingGetter = false
    var invokedOnCellTextDidEndEditingGetterCount = 0
    var stubbedOnCellTextDidEndEditing: ((TaskViewModel) -> ())!
    var onCellTextDidEndEditing: ((TaskViewModel) -> ())? {
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
