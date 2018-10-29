import UIKit

final class ListViewController: UIViewController {

    // MARK: - Dependencies
    var interactor: ListInteractor?
    var router: ListRouter?
    var tableDirector: ListViewTableDirector?

    // MARK: - State

    private var state: ListDataFlow.ViewControllerState = .loading {
        didSet {
            switch state {
            case .loading:
                startActivity()
                interactor?.fetchItems()
            case .error(let dialog):
                stopActivity()
                showAlert(dialog)
            case .result(let items, let listIdentifier):
                stopActivity()
                tableDirector?.items = items
                if let listIdentifier = listIdentifier {
                    let request = ListDataFlow.OpenListEditing.Request(identifier: listIdentifier)
                    interactor?.openListEditing(request: request)
                }
            case .editing(let listIdentifier):
                stopActivity()
                tableDirector?.focusOnList(listIdentifier)
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
    private var addListButton: UIBarButtonItem?

    // MARK: - ViewController life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        state = .loading

        tableDirector?.onListTap = { [weak self] listIdentifier in
            guard let self = `self` else {
                return
            }
            switch self.state {
            case .editing:
                break
            default:
                let request = ListDataFlow.OpenListActions.Request(identifier: listIdentifier)
                self.interactor?.openListActions(request: request)
            }
        }
        tableDirector?.onCellTextDidEndEditing = { [weak self] listIdentifier, text in
            let request = ListDataFlow.UpdateList.Request(
                identifier: listIdentifier,
                name: text
            )
            self?.interactor?.updateItem(request: request)
        }
        tableDirector?.onDeleteTap = { [weak self] listIdentifier in
            let request = ListDataFlow.DeleteList.Request(identifier: listIdentifier)
            self?.interactor?.deleteItem(request: request)
        }

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
        navigationItem.rightBarButtonItem = addListButton
    }

    // MARK: - Private

    @objc private func onAddListTap() {
        let request = ListDataFlow.CreateList.Request(name: "")
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

extension ListViewController: ListViewInput {
    func showEditing(_ identifier: Identifier) {
        self.state = .editing(listIdentifier: identifier)
    }

    func deleteItem(_ identifier: Identifier) {
        let request = ListDataFlow.DeleteList.Request(identifier: identifier)
        interactor?.deleteItem(request: request)
    }

    func openTasks(_ identifier: Identifier) {
        router?.openTasks(listIdentifier: identifier)
    }

    func showItems(_ viewModel: ListDataFlow.ShowLists.ViewModel) {
        self.state = viewModel.state
    }
}
