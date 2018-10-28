import Foundation

protocol ListPresenter: class {
    func presentShowList(_ response: ListDataFlow.ShowLists.Response)
    func presentError(_ error: StorageError)
}

final class ListPresenterImpl: ListPresenter {
    // MARK: - Dependencies
    private unowned let view: ListViewInput

    // MARK: - Init
    init(view: ListViewInput) {
        self.view = view
    }

    // MARK: - ListPresenter
    func presentShowList(_ response: ListDataFlow.ShowLists.Response) {
        let viewModel: ListDataFlow.ShowLists.ViewModel
        switch response.result {
        case .success(let items):
            let resultItems = items.map {
                ListViewModel(
                    identifier: $0.identifier ?? "",
                    name: $0.name
                )
            }
            viewModel = ListDataFlow.ShowLists.ViewModel(state: .result(items: resultItems))
        case .failure(let error):
            viewModel = errorStateViewModel(error)
        }
        view.showItems(viewModel)
    }

    func presentError(_ error: StorageError) {
        let viewModel = errorStateViewModel(error)
        view.showItems(viewModel)
    }

    // MARK: - Private

    func errorStateViewModel(_ error: StorageError) -> ListDataFlow.ShowLists.ViewModel {
        let message: String
        switch error {
        case .internalError:
            message = "Internal error 😕 Please try again!"
        case .cannotCreate,
             .cannotDelete,
             .cannotFetch,
             .cannotUpdate:
            message = "Incorrect input in the database 🤔"
        }
        return ListDataFlow.ShowLists.ViewModel(state: .error(message: message))
    }
}
