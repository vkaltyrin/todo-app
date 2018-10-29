import UIKit

final class TaskViewController: UIViewController {

    // MARK: - Dependencies
    var interactor: TaskInteractor?
    var tableDirector: TaskViewTableDirector?

    // MARK: - State

    private var state: TaskDataFlow.ViewControllerState = .loading {
        didSet {
            switch state {
            case .loading:
                startActivity()
                interactor?.fetchItems()
            case .error(let dialog):
                stopActivity()
                showAlert(dialog)
            case .result(let items, let identifier):
                stopActivity()
                tableDirector?.items = items
                if let identifier = identifier {
                    let request = TaskDataFlow.OpenTaskEditing.Request(identifier: identifier)
                    interactor?.openTaskEditing(request: request)
                }
            case .editing(let identifier):
                stopActivity()
                tableDirector?.focusOnTask(identifier)
            }
        }
    }

    private let keyboardObserver: KeyboardObserver = KeyboardObserverImpl()
    private var activityDisplayble: ActivityDisplayble?

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector?.setup(with: tableView)
        }
    }
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityDisplayble = ActivityDisplaybleImpl(
                activityIndicatorView: activityIndicator
            )
        }
    }

    // MARK: - Private views
    private var addTaskButton: UIBarButtonItem?

    // MARK: - ViewController life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        state = .loading

        tableDirector?.onTaskTap = { [weak self] identifier in
            guard let self = `self` else {
                return
            }
            switch self.state {
            case .editing:
                break
            default:
                let request = TaskDataFlow.OpenTaskActions.Request(identifier: identifier)
                self.interactor?.openTaskActions(request: request)
            }
        }
        tableDirector?.onCellTextDidEndEditing = { [weak self] identifier, text in
            let request = TaskDataFlow.UpdateTask.Request(
                identifier: identifier,
                name: text
            )
            self?.interactor?.updateItem(request: request)
        }
        tableDirector?.onDeleteTap = { [weak self] identifier in
            let request = TaskDataFlow.DeleteTask.Request(identifier: identifier)
            self?.interactor?.deleteItem(request: request)
        }

        keyboardObserver.onKeyboardWillShown = { [weak self] frame in
            self?.tableViewBottomConstraint.constant = frame.height
        }
        keyboardObserver.onKeyboardWillHide = { [weak self] in
            self?.tableViewBottomConstraint.constant = 0
        }

        addTaskButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onAddTaskTap)
        )
        addTaskButton?.qaAccessibilityIdentifier = TaskDataFlow.AccessibilityIdentifiers.createTaskButton
        navigationItem.rightBarButtonItem = addTaskButton
    }

    // MARK: - Private

    @objc private func onAddTaskTap() {
        let request = TaskDataFlow.CreateTask.Request(name: "")
        interactor?.createItem(request: request)
    }

    // MARK: - ActivityDisplayble

    func startActivity() {
        activityDisplayble?.startActivity()
    }

    func stopActivity() {
        activityDisplayble?.stopActivity()
    }
}

extension TaskViewController: TaskViewInput {
    func showEditing(_ identifier: Identifier) {
        self.state = .editing(identifier: identifier)
    }

    func deleteItem(_ identifier: Identifier) {
        let request = TaskDataFlow.DeleteTask.Request(identifier: identifier)
        interactor?.deleteItem(request: request)
    }

    func showItems(_ viewModel: TaskDataFlow.ShowTasks.ViewModel) {
        self.state = viewModel.state
    }
}
