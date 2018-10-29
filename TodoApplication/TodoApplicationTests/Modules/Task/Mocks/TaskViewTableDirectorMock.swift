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
    var invokedFocusOnTask = false
    var invokedFocusOnTaskCount = 0
    var invokedFocusOnTaskParameters: (identifier: Identifier, Void)?
    var invokedFocusOnTaskParametersList = [(identifier: Identifier, Void)]()

    func focusOnTask(_ identifier: Identifier) {
        invokedFocusOnTask = true
        invokedFocusOnTaskCount += 1
        invokedFocusOnTaskParameters = (identifier, ())
        invokedFocusOnTaskParametersList.append((identifier, ()))
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
