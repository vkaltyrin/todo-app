import Foundation

protocol ListPresenter: class {
    func presentItems(_ response: ListDataFlow.ShowLists.Response)
}

final class ListPresenterImpl: ListPresenter {
    // MARK: - Dependencies
    private unowned let view: ListViewInput

    // MARK: - Init
    init(view: ListViewInput) {
        self.view = view
    }

    // MARK: - ListPresenter
    func presentItems(_ response: ListDataFlow.ShowLists.Response) {

    }
}
