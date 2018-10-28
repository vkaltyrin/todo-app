import Foundation

protocol ListPresenter: class {
    func presentItems(_ response: ListViewShowItemsData.Response)
}

final class ListPresenterImpl: ListPresenter {
    // MARK: - Dependencies
    unowned let view: ListViewInput

    // MARK: - Init
    init(view: ListViewInput) {
        self.view = view
    }

    // MARK: - ListPresenter
    func presentItems(_ response: ListViewShowItemsData.Response) {

    }
}
