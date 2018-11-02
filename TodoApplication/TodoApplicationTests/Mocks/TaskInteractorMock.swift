@testable import TodoApplication
import XCTest

final class TaskInteractorMock: TaskInteractor {

    var invokedFetchItems = false
    var invokedFetchItemsCount = 0

    func fetchItems() {
        invokedFetchItems = true
        invokedFetchItemsCount += 1
    }

    var invokedDeleteItem = false
    var invokedDeleteItemCount = 0
    var invokedDeleteItemParameters: (request: TaskDataFlow.DeleteTask.Request, Void)?
    var invokedDeleteItemParametersList = [(request: TaskDataFlow.DeleteTask.Request, Void)]()

    func deleteItem(request: TaskDataFlow.DeleteTask.Request) {
        invokedDeleteItem = true
        invokedDeleteItemCount += 1
        invokedDeleteItemParameters = (request, ())
        invokedDeleteItemParametersList.append((request, ()))
    }

    var invokedUpdateItemName = false
    var invokedUpdateItemNameCount = 0
    var invokedUpdateItemNameParameters: (request: TaskDataFlow.UpdateTaskName.Request, Void)?
    var invokedUpdateItemNameParametersList = [(request: TaskDataFlow.UpdateTaskName.Request, Void)]()

    func updateItemName(request: TaskDataFlow.UpdateTaskName.Request) {
        invokedUpdateItemName = true
        invokedUpdateItemNameCount += 1
        invokedUpdateItemNameParameters = (request, ())
        invokedUpdateItemNameParametersList.append((request, ()))
    }

    var invokedUpdateItemDoneness = false
    var invokedUpdateItemDonenessCount = 0
    var invokedUpdateItemDonenessParameters: (request: TaskDataFlow.UpdateTaskDoneness.Request, Void)?
    var invokedUpdateItemDonenessParametersList = [(request: TaskDataFlow.UpdateTaskDoneness.Request, Void)]()

    func updateItemDoneness(request: TaskDataFlow.UpdateTaskDoneness.Request) {
        invokedUpdateItemDoneness = true
        invokedUpdateItemDonenessCount += 1
        invokedUpdateItemDonenessParameters = (request, ())
        invokedUpdateItemDonenessParametersList.append((request, ()))
    }

    var invokedCreateItem = false
    var invokedCreateItemCount = 0
    var invokedCreateItemParameters: (request: TaskDataFlow.CreateTask.Request, Void)?
    var invokedCreateItemParametersList = [(request: TaskDataFlow.CreateTask.Request, Void)]()

    func createItem(request: TaskDataFlow.CreateTask.Request) {
        invokedCreateItem = true
        invokedCreateItemCount += 1
        invokedCreateItemParameters = (request, ())
        invokedCreateItemParametersList.append((request, ()))
    }

    var invokedOpenTaskActions = false
    var invokedOpenTaskActionsCount = 0
    var invokedOpenTaskActionsParameters: (request: TaskDataFlow.OpenTaskActions.Request, Void)?
    var invokedOpenTaskActionsParametersList = [(request: TaskDataFlow.OpenTaskActions.Request, Void)]()

    func openTaskActions(request: TaskDataFlow.OpenTaskActions.Request) {
        invokedOpenTaskActions = true
        invokedOpenTaskActionsCount += 1
        invokedOpenTaskActionsParameters = (request, ())
        invokedOpenTaskActionsParametersList.append((request, ()))
    }

    var invokedOpenTaskEditing = false
    var invokedOpenTaskEditingCount = 0
    var invokedOpenTaskEditingParameters: (request: TaskDataFlow.OpenTaskEditing.Request, Void)?
    var invokedOpenTaskEditingParametersList = [(request: TaskDataFlow.OpenTaskEditing.Request, Void)]()

    func openTaskEditing(request: TaskDataFlow.OpenTaskEditing.Request) {
        invokedOpenTaskEditing = true
        invokedOpenTaskEditingCount += 1
        invokedOpenTaskEditingParameters = (request, ())
        invokedOpenTaskEditingParametersList.append((request, ()))
    }
}
