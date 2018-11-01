import UIKit

final class ListViewController: UIViewController {

    // MARK: - Dependencies
    var interactor: ListInteractor?
    var router: ListRouter?
    var tableManager: TableManager?

    private let keyboardObserver: KeyboardObserver = KeyboardObserverImpl()
    private var activityDisplayable: ActivityDisplayable?

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableManager = TableManagerImpl(tableView: tableView)
        }
    }
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityDisplayable = ActivityDisplayableImpl(
                activityIndicatorView: activityIndicator
            )
        }
    }

    // MARK: - Private views
    private var addListButton: UIBarButtonItem?

    // MARK: - ViewController life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchItems()

        keyboardObserver.onKeyboardWillShown = { [weak self] frame in
            self?.tableViewBottomConstraint.constant = frame.height
        }
        keyboardObserver.onKeyboardWillHide = { [weak self] in
            self?.tableViewBottomConstraint.constant = 0
        }

        addListButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onAddListTap)
        )
        addListButton?.qaAccessibilityIdentifier = ListDataFlow.AccessibilityIdentifiers.createListButton
        navigationItem.rightBarButtonItem = addListButton
    }

    // MARK: - Private

    @objc private func onAddListTap() {
        let request = ListDataFlow.CreateList.Request(name: "")
        interactor?.createItem(request: request)
    }

    // MARK: - ActivityDisplayable

    func startActivity() {
        activityDisplayable?.startActivity()
    }

    func stopActivity() {
        activityDisplayable?.stopActivity()
    }
}

extension ListViewController: ListViewInput {
    func focusOn(_ identifier: Identifier) {
        tableManager?.focusOn(sectionIndex: 0) { (cell: TableCell<ListCell>) -> Bool in
            cell.viewModel.identifier == identifier
        }
    }

    func fetchItems() {
        interactor?.fetchItems()
    }

    func reloadTable(_ sections: [TableSection]) {
        tableManager?.reload(sections)
    }

    func updateItem(_ identifier: Identifier, name: String) {
        let request = ListDataFlow.UpdateList.Request(
            identifier: identifier,
            name: name
        )
        interactor?.updateItem(request: request)
    }

    func selectItem(_ identifier: Identifier, name: String) {
        let request = ListDataFlow.OpenListActions.Request(
            identifier: identifier,
            name: name
        )
        interactor?.openListActions(request: request)
    }

    func showEditing(_ identifier: Identifier) {
        let request = ListDataFlow.OpenListEditing.Request(identifier: identifier)
        interactor?.openListEditing(request: request)
    }

    func deleteItem(_ identifier: Identifier) {
        let request = ListDataFlow.DeleteList.Request(identifier: identifier)
        interactor?.deleteItem(request: request)
    }

    func openTasks(_ identifier: Identifier, name: String) {
        router?.openTasks(listIdentifier: identifier, name: name)
    }
}
