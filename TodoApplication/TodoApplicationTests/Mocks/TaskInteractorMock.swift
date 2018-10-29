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

    var invokedUpdateItem = false
    var invokedUpdateItemCount = 0
    var invokedUpdateItemParameters: (request: TaskDataFlow.UpdateTask.Request, Void)?
    var invokedUpdateItemParametersList = [(request: TaskDataFlow.UpdateTask.Request, Void)]()

    func updateItem(request: TaskDataFlow.UpdateTask.Request) {
        invokedUpdateItem = true
        invokedUpdateItemCount += 1
        invokedUpdateItemParameters = (request, ())
        invokedUpdateItemParametersList.append((request, ()))
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
