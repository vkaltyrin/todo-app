import UIKit

final class TaskViewController: UIViewController {

    // MARK: - Dependencies
    var interactor: TaskInteractor?
    var tableManager: TableManager?
    var activityDisplayable: ActivityDisplayable?

    // MARK: - Private
    private var onAddTap: (() -> ())?
    private let keyboardObserver: KeyboardObserver = KeyboardObserverImpl()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableManager?.setTableView(tableView)
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

        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onAddTaskTap)
        )
        addButton.qaAccessibilityIdentifier = TaskDataFlow.AccessibilityIdentifiers.createTaskButton
        navigationItem.rightBarButtonItem = addButton
    }

    // MARK: - Private

    @objc private func onAddTaskTap() {
        onAddTap?()
    }
}

extension TaskViewController: ActivityDisplayable {
    func startActivity() {
        activityDisplayable?.startActivity()
    }

    func stopActivity() {
        activityDisplayable?.stopActivity()
    }
}

extension TaskViewController: TaskViewInput {
    func setOnAddTap(_ onAddTap: (() -> ())?) {
        self.onAddTap = onAddTap
    }

    func createItem(name: String) {
        view.endEditing(true)
        let request = TaskDataFlow.CreateTask.Request(name: name)
        interactor?.createItem(request: request)
    }

    func focusOn(_ identifier: Identifier) {
        tableManager?.focusOn(sectionIndex: 0) { (cell: TableCell<TaskCell>) -> Bool in
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
        let request = TaskDataFlow.UpdateTaskName.Request(
            identifier: identifier,
            name: name
        )
        interactor?.updateItemName(request: request)
    }

    func updateItem(_ identifier: Identifier, isDone: Bool) {
        let request = TaskDataFlow.UpdateTaskDoneness.Request(
            identifier: identifier,
            isDone: isDone
        )
        interactor?.updateItemDoneness(request: request)
    }

    func selectItem(_ identifier: Identifier, name: String) {
        let request = TaskDataFlow.OpenTaskActions.Request(
            identifier: identifier
        )
        interactor?.openTaskActions(request: request)
    }

    func showEditing(_ identifier: Identifier) {
        let request = TaskDataFlow.OpenTaskEditing.Request(identifier: identifier)
        interactor?.openTaskEditing(request: request)
    }

    func deleteItem(_ identifier: Identifier) {
        let request = TaskDataFlow.DeleteTask.Request(identifier: identifier)
        interactor?.deleteItem(request: request)
    }
}
