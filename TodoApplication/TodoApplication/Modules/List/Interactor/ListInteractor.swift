import Foundation

protocol ListInteractor: class {
    func fetchItems()
    func deleteItem(request: ListDataFlow.DeleteList.Request)
    func updateItem(request: ListDataFlow.UpdateList.Request)
    func createItem(request: ListDataFlow.CreateList.Request)
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
        listStorage.fetchLists { [weak self] result in
            let response = ListDataFlow.ShowLists.Response(result: result)
            self?.presenter.presentShowList(response)
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
                break
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func createItem(request: ListDataFlow.CreateList.Request) {
        let list = List(name: request.name)
        listStorage.createList(list) { [weak self] _ in
            self?.fetchItems()
        }
    }
}
