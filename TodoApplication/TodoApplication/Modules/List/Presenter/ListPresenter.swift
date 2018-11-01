import Foundation

protocol ListPresenter: class {
    func presentShowLists(_ response: ListDataFlow.ShowLists.Response, identifier: Identifier?)
    func presentError(_ error: StorageError)
    func presentListActions(_ identifier: Identifier, name: String)
    func presentListEditing(_ identifier: Identifier)
    func presentLoading()
}

final class ListPresenterImpl: ListPresenter {
    // MARK: - Dependencies
    private unowned let view: ListViewInput

    // MARK: - Init
    init(view: ListViewInput) {
        self.view = view
        initialSetup()
    }

    // MARK: - ListPresenter
    func presentShowLists(_ response: ListDataFlow.ShowLists.Response, identifier: Identifier?) {
        let viewModel: ListDataFlow.ShowLists.ViewModel
        switch response.result {
        case .success(let items):
            let resultItems = items.map {
                ListViewModel(
                    identifier: $0.identifier ?? "",
                    name: $0.name
                )
            }

            let builder = ListTableBuilder(
                items: resultItems,
                focusIdentifier: identifier,
                onDeleteTap: { [weak self] identifier in
                    self?.view.deleteItem(identifier)
                },
                onListTap: { [weak self] item in
                    self?.onListTap(item: item)
                },
                onCellTextDidEndEditing: { [weak self] item in
                    self?.view.updateItem(item.identifier, name: item.name)
                }
            )
            let sections = builder.build()

            viewModel = ListDataFlow.ShowLists.ViewModel(state: .result(
                items: sections,
                listIdentifier: identifier
                )
            )
        case .failure(let error):
            viewModel = ListDataFlow.ShowLists.ViewModel(state: .error(dialog: errorDialog(error))
            )
        }

        state = viewModel.state
    }

    func presentError(_ error: StorageError) {
        state = .error(dialog: errorDialog(error))
    }

    func presentListActions(_ identifier: Identifier, name: String) {
        let actions: [Dialog.Action] = [
            Dialog.Action(
                title: "Edit list 📝",
                style: .default) { [weak self] in
                    self?.view.showEditing(identifier)
            },
            Dialog.Action(
                title: "Delete list and all containing tasks 🗑",
                style: .default) { [weak self] in
                    self?.view.deleteItem(identifier)
            },
            Dialog.Action(
                title: "Look at tasks ▶️",
                style: .default) { [weak self] in
                    self?.view.openTasks(identifier, name: name)
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

    func presentListEditing(_ identifier: Identifier) {
        self.state = .editing(listIdentifier: identifier)
    }

    func presentLoading() {
        self.state = .loading
    }

    // MARK: - Private
    private func initialSetup() {
        view.setOnAddTap { [weak self] in
            self?.view.createTask(name: "")
        }
    }

    private func onListTap(item: ListViewModel) {
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

    private var state: ListDataFlow.ViewState = .loading {
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
                    self.state = .editing(listIdentifier: identifier)
                }
            case .editing(let identifier):
                view.stopActivity()
                view.focusOn(identifier)
            }
        }
    }
}
