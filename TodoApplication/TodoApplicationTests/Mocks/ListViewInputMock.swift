@testable import TodoApplication
import XCTest

final class ListViewInputMock: ListViewInput {

    var invokedShowEditing = false
    var invokedShowEditingCount = 0
    var invokedShowEditingParameters: (identifier: Identifier, Void)?
    var invokedShowEditingParametersList = [(identifier: Identifier, Void)]()

    func showEditing(_ identifier: Identifier) {
        invokedShowEditing = true
        invokedShowEditingCount += 1
        invokedShowEditingParameters = (identifier, ())
        invokedShowEditingParametersList.append((identifier, ()))
    }

    var invokedDeleteItem = false
    var invokedDeleteItemCount = 0
    var invokedDeleteItemParameters: (identifier: Identifier, Void)?
    var invokedDeleteItemParametersList = [(identifier: Identifier, Void)]()

    func deleteItem(_ identifier: Identifier) {
        invokedDeleteItem = true
        invokedDeleteItemCount += 1
        invokedDeleteItemParameters = (identifier, ())
        invokedDeleteItemParametersList.append((identifier, ()))
    }

    var invokedOpenTasks = false
    var invokedOpenTasksCount = 0
    var invokedOpenTasksParameters: (identifier: Identifier, name: String)?
    var invokedOpenTasksParametersList = [(identifier: Identifier, name: String)]()

    func openTasks(_ identifier: Identifier, name: String) {
        invokedOpenTasks = true
        invokedOpenTasksCount += 1
        invokedOpenTasksParameters = (identifier, name)
        invokedOpenTasksParametersList.append((identifier, name))
    }

    var invokedSelectItem = false
    var invokedSelectItemCount = 0
    var invokedSelectItemParameters: (identifier: Identifier, name: String)?
    var invokedSelectItemParametersList = [(identifier: Identifier, name: String)]()

    func selectItem(_ identifier: Identifier, name: String) {
        invokedSelectItem = true
        invokedSelectItemCount += 1
        invokedSelectItemParameters = (identifier, name)
        invokedSelectItemParametersList.append((identifier, name))
    }

    var invokedUpdateItem = false
    var invokedUpdateItemCount = 0
    var invokedUpdateItemParameters: (identifier: Identifier, name: String)?
    var invokedUpdateItemParametersList = [(identifier: Identifier, name: String)]()

    func updateItem(_ identifier: Identifier, name: String) {
        invokedUpdateItem = true
        invokedUpdateItemCount += 1
        invokedUpdateItemParameters = (identifier, name)
        invokedUpdateItemParametersList.append((identifier, name))
    }

    var invokedCreateItem = false
    var invokedCreateItemCount = 0
    var invokedCreateItemParameters: (name: String, Void)?
    var invokedCreateItemParametersList = [(name: String, Void)]()

    func createItem(name: String) {
        invokedCreateItem = true
        invokedCreateItemCount += 1
        invokedCreateItemParameters = (name, ())
        invokedCreateItemParametersList.append((name, ()))
    }

    var invokedFetchItems = false
    var invokedFetchItemsCount = 0

    func fetchItems() {
        invokedFetchItems = true
        invokedFetchItemsCount += 1
    }

    var invokedReloadTable = false
    var invokedReloadTableCount = 0
    var invokedReloadTableParameters: (sections: [TableSection], Void)?
    var invokedReloadTableParametersList = [(sections: [TableSection], Void)]()

    func reloadTable(_ sections: [TableSection]) {
        invokedReloadTable = true
        invokedReloadTableCount += 1
        invokedReloadTableParameters = (sections, ())
        invokedReloadTableParametersList.append((sections, ()))
    }

    var invokedFocusOn = false
    var invokedFocusOnCount = 0
    var invokedFocusOnParameters: (identifier: Identifier, Void)?
    var invokedFocusOnParametersList = [(identifier: Identifier, Void)]()

    func focusOn(_ identifier: Identifier) {
        invokedFocusOn = true
        invokedFocusOnCount += 1
        invokedFocusOnParameters = (identifier, ())
        invokedFocusOnParametersList.append((identifier, ()))
    }

    var invokedSetOnAddTap = false
    var invokedSetOnAddTapCount = 0
    var shouldInvokeSetOnAddTapOnAddTap = false

    func setOnAddTap(_ onAddTap: (() -> ())?) {
        invokedSetOnAddTap = true
        invokedSetOnAddTapCount += 1
        if shouldInvokeSetOnAddTapOnAddTap {
            onAddTap?()
        }
    }

    var invokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (dialog: Dialog, Void)?
    var invokedShowAlertParametersList = [(dialog: Dialog, Void)]()

    func showAlert(_ dialog: Dialog) {
        invokedShowAlert = true
        invokedShowAlertCount += 1
        invokedShowAlertParameters = (dialog, ())
        invokedShowAlertParametersList.append((dialog, ()))
    }

    var invokedShowActionSheet = false
    var invokedShowActionSheetCount = 0
    var invokedShowActionSheetParameters: (dialog: Dialog, Void)?
    var invokedShowActionSheetParametersList = [(dialog: Dialog, Void)]()

    func showActionSheet(_ dialog: Dialog) {
        invokedShowActionSheet = true
        invokedShowActionSheetCount += 1
        invokedShowActionSheetParameters = (dialog, ())
        invokedShowActionSheetParametersList.append((dialog, ()))
    }

    var invokedStartActivity = false
    var invokedStartActivityCount = 0

    func startActivity() {
        invokedStartActivity = true
        invokedStartActivityCount += 1
    }

    var invokedStopActivity = false
    var invokedStopActivityCount = 0

    func stopActivity() {
        invokedStopActivity = true
        invokedStopActivityCount += 1
    }
}
