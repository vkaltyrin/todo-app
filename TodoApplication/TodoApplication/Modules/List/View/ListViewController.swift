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
                startLoading()
                interactor?.fetchItems()
            case .error(let dialog):
                stopLoading()
                showAlert(dialog)
            case .result(let items):
                stopLoading()
                tableDirector?.items = items
            case .editing(let listIdentifier):
                stopLoading()
                tableDirector?.focusOnList(listIdentifier)
//            case .create(let listIdentifier, let items):
//                stopLoading()var items: [ListViewModel] = []
//                tableDirector.items = items
//                self.state = .editing(listIdentifier: listIdentifier)
            }
        }
    }

    private let keyboardObserver: KeyboardObserver = KeyboardObserverImpl()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector?.setup(with: tableView)
        }
    }
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
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

    private func startLoading() {
        activityIndicator.startAnimating()
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
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
