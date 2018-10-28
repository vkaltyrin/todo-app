import Foundation

protocol ListInteractor: class {
    func fetchItems()
    func deleteItem(request: ListDataFlow.DeleteList.Request)
    func updateItem(request: ListDataFlow.UpdateList.Request)
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

    }

    func deleteItem(request: ListDataFlow.DeleteList.Request) {

    }

    func updateItem(request: ListDataFlow.UpdateList.Request) {

    }

}
