import Foundation

protocol ListInteractor: class {

}

final class ListInteractorImpl: ListInteractor {
    let presenter: ListPresenter
    let listStorage: ListStorage

    init(presenter: ListPresenter, listStorage: ListStorage) {
        self.presenter = presenter
        self.listStorage = listStorage
    }
}
