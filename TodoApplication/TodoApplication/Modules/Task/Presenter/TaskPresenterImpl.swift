import Foundation

final class TaskPresenterImpl {
    // MARK: - Dependencies
    private unowned let view: TaskViewInput

    // MARK: - Init
    init(view: TaskViewInput) {
        self.view = view
        initialSetup()
    }

    // MARK: - Private
    private func initialSetup() {
        view.setOnAddTap { [weak self] in
            self?.view.createItem(name: "")
        }
    }

    private func onTaskTap(item: TaskViewModel) {
        switch state {
        case .editing:
            break
        default:
            view.selectItem(item.identifier, name: item.name)
        }
    }

    private func errorDialog(_ error: StorageError) -> Dialog {
        return DialogBuilder().build(storageError: error)
    }

    private var state: TaskDataFlow.ViewState = .loading {
        didSet {
            switch state {
            case .loading:
                view.startActivity()
            case .error(let dialog):
                view.stopActivity()
                view.showAlert(dialog)
            case .result(let sections, let identifier):
                view.stopActivity()
                view.reloadTable(sections)
                if let identifier = identifier {
                    presentTaskEditing(identifier)
                }
            case .editing(let identifier):
                view.stopActivity()
                view.focusOn(identifier)
            }
        }
    }
}

extension TaskPresenterImpl: TaskPresenter {
    func presentShowTasks(_ response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?) {
        let viewModel: TaskDataFlow.ShowTasks.ViewModel
        switch response.result {
        case .success(let items):
            let resultItems: [TaskViewModel] = items.map { item in
                let identifier = item.identifier ?? ""
                return TaskViewModel(
                    identifier: identifier,
                    name: item.name,
                    isDone: item.isDone,
                    onSwitchTap: { [weak self] isDone in
                        self?.view.updateItem(identifier, isDone: isDone)
                    }
                )
            }

            let builder = TaskTableBuilder(
                items: resultItems,
                focusIdentifier: identifier,
                onDeleteTap: { [weak self] identifier in
                    self?.view.deleteItem(identifier)
                },
                onTaskTap: { [weak self] item in
                    self?.onTaskTap(item: item)
                },
                onCellTextDidEndEditing: { [weak self] item in
                    self?.view.updateItem(item.identifier, name: item.name)
                }
            )
            let sections = builder.build()

            viewModel = TaskDataFlow.ShowTasks.ViewModel(state: .result(
                items: sections,
                identifier: identifier
                )
            )
        case .failure(let error):
            viewModel = TaskDataFlow.ShowTasks.ViewModel(state: .error(dialog: errorDialog(error))
            )
        }

        state = viewModel.state
    }

    func presentError(_ error: StorageError) {
        state = .error(dialog: errorDialog(error))
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
        self.state = .editing(identifier: identifier)
    }

    func presentLoading() {
        self.state = .loading
    }
}
