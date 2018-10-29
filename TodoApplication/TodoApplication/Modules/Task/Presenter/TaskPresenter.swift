import Foundation

protocol TaskPresenter: class {
    func presentShowTasks(_ response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?)
    func presentError(_ error: StorageError)
    func presentTaskActions(_ identifier: Identifier)
    func presentTaskEditing(_ identifier: Identifier)
}

final class TaskPresenterImpl: TaskPresenter {
    // MARK: - Dependencies
    private unowned let view: TaskViewInput

    // MARK: - Init
    init(view: TaskViewInput) {
        self.view = view
    }

    // MARK: - TaskPresenter
    func presentShowTasks(_ response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?) {
        let viewModel: TaskDataFlow.ShowTasks.ViewModel
        switch response.result {
        case .success(let items):
            let resultItems = items.map {
                TaskViewModel(
                    identifier: $0.identifier ?? "",
                    name: $0.name
                )
            }
            viewModel = TaskDataFlow.ShowTasks.ViewModel(state: .result(
                items: resultItems,
                identifier: identifier
                )
            )
        case .failure(let error):
            viewModel = errorStateViewModel(error)
        }
        view.showItems(viewModel)
    }

    func presentError(_ error: StorageError) {
        let viewModel = errorStateViewModel(error)
        view.showItems(viewModel)
    }

    func presentTaskActions(_ identifier: Identifier) {
        let actions: [Dialog.Action] = [
            Dialog.Action(
                title: "Edit todo 📝",
                style: .default) { [weak self] in
                    self?.view.showEditing(identifier)
            },
            Dialog.Action(
                title: "Delete 🗑",
                style: .default) { [weak self] in
                    self?.view.deleteItem(identifier)
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

    func presentTaskEditing(_ identifier: Identifier) {
        view.showEditing(identifier)
    }

    // MARK: - Private
    func errorStateViewModel(_ error: StorageError) -> TaskDataFlow.ShowTasks.ViewModel {
        let dialogBuilder = DialogBuilder()
        let dialog = dialogBuilder.build(storageError: error)

        return TaskDataFlow.ShowTasks.ViewModel(state: .error(dialog: dialog))
    }
}
