@testable import TodoApplication
import XCTest

final class ListViewInputMock: ListViewInput {

    var invokedShowItems = false
    var invokedShowItemsCount = 0
    var invokedShowItemsParameters: (viewModel: ListDataFlow.ShowLists.ViewModel, Void)?
    var invokedShowItemsParametersList = [(viewModel: ListDataFlow.ShowLists.ViewModel, Void)]()

    func showItems(_ viewModel: ListDataFlow.ShowLists.ViewModel) {
        invokedShowItems = true
        invokedShowItemsCount += 1
        invokedShowItemsParameters = (viewModel, ())
        invokedShowItemsParametersList.append((viewModel, ()))
    }

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
