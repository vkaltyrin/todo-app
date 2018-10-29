import Foundation

protocol ListPresenter: class {
    func presentShowList(_ response: ListDataFlow.ShowLists.Response)
    func presentError(_ error: StorageError)
    func presentListActions(_ identifier: Identifier)
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

    func presentListActions(_ identifier: Identifier) {
        let actions: [Dialog.Action] = [
            Dialog.Action(
                title: "Edit 📝",
                style: .default) { [weak self] in
                    self?.view.showEditing(identifier)
            },
            Dialog.Action(
                title: "Delete 🗑",
                style: .default) { [weak self] in
                    self?.view.deleteItem(identifier)
            },
            Dialog.Action(
                title: "View tasks ▶️",
                style: .default) { [weak self] in
                    self?.view.openTasks(identifier)
            },
            Dialog.Action(
                title: "Cancel",
                style: .cancel,
                onTap: nil
            )
        ]
        let dialog = Dialog(actions: actions)
        view.showActionSheet(dialog)
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

        let action = Dialog.Action(
            title: "OK",
            style: .cancel,
            onTap: nil
        )
        let dialog = Dialog(
            title: nil,
            message: message,
            actions: [action]
        )

        return ListDataFlow.ShowLists.ViewModel(state: .error(dialog: dialog))
    }
}
