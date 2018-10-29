@testable import TodoApplication
import XCTest

final class ListInteractorMock: ListInteractor {

    var invokedFetchItems = false
    var invokedFetchItemsCount = 0

    func fetchItems() {
        invokedFetchItems = true
        invokedFetchItemsCount += 1
    }

    var invokedDeleteItem = false
    var invokedDeleteItemCount = 0
    var invokedDeleteItemParameters: (request: ListDataFlow.DeleteList.Request, Void)?
    var invokedDeleteItemParametersList = [(request: ListDataFlow.DeleteList.Request, Void)]()

    func deleteItem(request: ListDataFlow.DeleteList.Request) {
        invokedDeleteItem = true
        invokedDeleteItemCount += 1
        invokedDeleteItemParameters = (request, ())
        invokedDeleteItemParametersList.append((request, ()))
    }

    var invokedUpdateItem = false
    var invokedUpdateItemCount = 0
    var invokedUpdateItemParameters: (request: ListDataFlow.UpdateList.Request, Void)?
    var invokedUpdateItemParametersList = [(request: ListDataFlow.UpdateList.Request, Void)]()

    func updateItem(request: ListDataFlow.UpdateList.Request) {
        invokedUpdateItem = true
        invokedUpdateItemCount += 1
        invokedUpdateItemParameters = (request, ())
        invokedUpdateItemParametersList.append((request, ()))
    }

    var invokedCreateItem = false
    var invokedCreateItemCount = 0
    var invokedCreateItemParameters: (request: ListDataFlow.CreateList.Request, Void)?
    var invokedCreateItemParametersList = [(request: ListDataFlow.CreateList.Request, Void)]()

    func createItem(request: ListDataFlow.CreateList.Request) {
        invokedCreateItem = true
        invokedCreateItemCount += 1
        invokedCreateItemParameters = (request, ())
        invokedCreateItemParametersList.append((request, ()))
    }

    var invokedOpenListActions = false
    var invokedOpenListActionsCount = 0
    var invokedOpenListActionsParameters: (request: ListDataFlow.OpenListActions.Request, Void)?
    var invokedOpenListActionsParametersList = [(request: ListDataFlow.OpenListActions.Request, Void)]()

    func openListActions(request: ListDataFlow.OpenListActions.Request) {
        invokedOpenListActions = true
        invokedOpenListActionsCount += 1
        invokedOpenListActionsParameters = (request, ())
        invokedOpenListActionsParametersList.append((request, ()))
    }

    var invokedOpenListEditing = false
    var invokedOpenListEditingCount = 0
    var invokedOpenListEditingParameters: (request: ListDataFlow.OpenListEditing.Request, Void)?
    var invokedOpenListEditingParametersList = [(request: ListDataFlow.OpenListEditing.Request, Void)]()

    func openListEditing(request: ListDataFlow.OpenListEditing.Request) {
        invokedOpenListEditing = true
        invokedOpenListEditingCount += 1
        invokedOpenListEditingParameters = (request, ())
        invokedOpenListEditingParametersList.append((request, ()))
    }
}
