import Foundation

protocol ListPresenter: class {
    func presentShowList(_ response: ListDataFlow.ShowLists.Response)
    func presentGeneralError(_ response: ListDataFlow.GeneralError.Response)
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
            break
        case .failure(let error):
            viewModel = errorStateViewModel(error)
        }
        //view.showItems(viewModel)
    }

    func presentGeneralError(_ response: ListDataFlow.GeneralError.Response) {
        let viewModel = errorStateViewModel(response.result)
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
