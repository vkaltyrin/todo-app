import UIKit

final class ListViewController: UIViewController {

    // MARK: - Dependencies
    var interactor: ListInteractor?
    var router: ListRouter?

    // MARK: - State
    private var tableDirector = ListViewTableDirector()

    private var state: ViewControllerState<ListViewModel> = .loading {
        didSet {
            switch state {
            case .loading:
                startLoading()
                interactor?.fetchItems()
            case .error(let message):
                stopLoading()
                showError(message: message)
            case .result(let items):
                stopLoading()
                tableDirector.items = items
            }
        }
    }

    private let keyboardObserver: KeyboardObserver = KeyboardObserverImpl()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector.tableView = tableView
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

        tableDirector.onListTap = { [weak self] listIdentifier in
            self?.showListActions(listIdentifier)
        }
        tableDirector.onCellTextDidEndEditing = { [weak self] listIdentifier, text in
            let request = ListDataFlow.UpdateList.Request(
                identifier: listIdentifier,
                name: text
            )
            self?.interactor?.updateItem(request: request)
        }
        tableDirector.onDeleteTap = { [weak self] listIdentifier in
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

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

    func showError(message: String) {
        let alert = UIAlertController(
            title: "Error 🚫",
            message: message,
            preferredStyle: .alert
        )

        let closeAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil
        )
        alert.addAction(closeAction)

        present(alert, animated: true, completion: nil)
    }

    private func showListActions(_ listIdentifier: Identifier) {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let editAciton = UIAlertAction(title: "Edit 📝", style: .default) { _ in

        }
        actionSheet.addAction(editAciton)

        let deleteAction = UIAlertAction(title: "Delete 🗑", style: .default) { [weak self] _ in
            let request = ListDataFlow.DeleteList.Request(identifier: listIdentifier)
            self?.interactor?.deleteItem(request: request)
        }
        actionSheet.addAction(deleteAction)

        let openAction = UIAlertAction(title: "View tasks ▶️", style: .default) { [weak self] _ in
            self?.router?.openTasks(listIdentifier: listIdentifier)
        }
        actionSheet.addAction(openAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension ListViewController: ListViewInput {
    func showItems(_ viewModel: ListDataFlow.ShowLists.ViewModel) {
        self.state = viewModel.state
    }
}
