import Foundation

protocol ListInteractor: class {
    func fetchItems()
    func deleteItem(request: ListDataFlow.DeleteList.Request)
    func updateItem(request: ListDataFlow.UpdateList.Request)
    func createItem(request: ListDataFlow.CreateList.Request)
    func openListActions(request: ListDataFlow.OpenListActions.Request)
    func openListEditing(request: ListDataFlow.OpenListEditing.Request)
}

final class ListInteractorImpl: ListInteractor {
    // MARK: - Dependencies
    private let presenter: ListPresenter
    private let listStorage: ListStorage

    // MARK: - Init
    init(presenter: ListPresenter, listStorage: ListStorage) {
        self.presenter = presenter
        self.listStorage = listStorage
    }

    // MARK: - ListInteractor
    func fetchItems() {
        fetchItemsResponse { [weak self] response in
            self?.presenter.presentShowLists(response, identifier: nil)
        }
    }

    func deleteItem(request: ListDataFlow.DeleteList.Request) {
        listStorage.deleteList(listId: request.identifier) { [weak self] result in
            let response = ListDataFlow.DeleteList.Response(result: result)
            switch response.result {
            case .success:
                self?.fetchItems()
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func updateItem(request: ListDataFlow.UpdateList.Request) {
        listStorage.updateList(listId: request.identifier, name: request.name) { [weak self] result in
            let response = ListDataFlow.UpdateList.Response(result: result)
            switch response.result {
            case .success:
                self?.fetchItems()
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func createItem(request: ListDataFlow.CreateList.Request) {
        let list = List(name: request.name)
        listStorage.createList(list) { [weak self] result in
            switch result {
            case .success(let identifier):
                self?.listStorage.fetchLists { _ in
                    self?.fetchItemsResponse { response in
                        self?.presenter.presentShowLists(response, identifier: identifier)
                    }
                }
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func openListActions(request: ListDataFlow.OpenListActions.Request) {
        presenter.presentListActions(
            request.identifier,
            name: request.name
        )
    }

    func openListEditing(request: ListDataFlow.OpenListEditing.Request) {
        presenter.presentListEditing(request.identifier)
    }

    // MARK: - Private

    private func fetchItemsResponse(completion: @escaping (ListDataFlow.ShowLists.Response) -> ()) {
        listStorage.fetchLists { result in
            let response = ListDataFlow.ShowLists.Response(result: result)
            completion(response)
        }
    }
}
