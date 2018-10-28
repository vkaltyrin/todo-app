import Foundation

protocol ListInteractor: class {
    func fetchItems()
}

final class ListInteractorImpl: ListInteractor {
    // MARK: - Dependencies
    let presenter: ListPresenter
    let listStorage: ListStorage

    // MARK: - Init
    init(presenter: ListPresenter, listStorage: ListStorage) {
        self.presenter = presenter
        self.listStorage = listStorage
    }

    // MARK: - ListInteractor
    func fetchItems() {

    }
}
