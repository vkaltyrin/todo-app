import Foundation

protocol ListPresenter: class {
    func presentShowLists(_ response: ListDataFlow.ShowLists.Response, identifier: Identifier?)
    func presentError(_ error: StorageError)
    func presentListActions(_ identifier: Identifier, name: String)
    func presentListEditing(_ identifier: Identifier)
}

final class ListPresenterImpl: ListPresenter {
    // MARK: - Dependencies
    private unowned let view: ListViewInput

    // MARK: - Init
    init(view: ListViewInput) {
        self.view = view
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
            viewModel = errorStateViewModel(error)
        }

        state = viewModel.state
        //view.showItems(viewModel)
    }

    func presentError(_ error: StorageError) {
        let viewModel = errorStateViewModel(error)
        view.showItems(viewModel)
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
        //view.showEditing(identifier)
        self.state = .editing(listIdentifier: identifier)
    }

    // MARK: - Private
    private func onListTap(item: ListViewModel) {
        switch state {
        case .editing:
            break
        default:
            view.selectItem(item.identifier, name: item.name)
        }
    }

    private func errorStateViewModel(_ error: StorageError) -> ListDataFlow.ShowLists.ViewModel {
        let dialogBuilder = DialogBuilder()
        let dialog = dialogBuilder.build(storageError: error)
        return ListDataFlow.ShowLists.ViewModel(state: .error(dialog: dialog))
    }

    private var state: ListDataFlow.ViewControllerState = .loading {
        didSet {
            switch state {
            case .loading:
                view.startActivity()
                view.fetchItems()
            case .error(let dialog):
                view.stopActivity()
                view.showAlert(dialog)
            case .result(let sections, let identifier):
                view.stopActivity()
                view.reloadTable(sections)
                if let identifier = identifier {
                    //view.showEditing(identifier)
                    self.state = .editing(listIdentifier: identifier)
                }
            case .editing(let identifier):
                view.stopActivity()
                view.focusOn(identifier)
            }
        }
    }
}
