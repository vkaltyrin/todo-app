import UIKit

final class ListViewController: UIViewController {

    // MARK: - Dependencies
    var interactor: ListInteractor?
    var router: ListRouter?

    // MARK: - State
    private var listViewTableDelegate: UITableViewDelegate = ListViewTableDelegate()
    private var listViewDataSource: UITableViewDataSource = ListViewDataSource()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!

    // MARK: - ViewController life-cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = listViewTableDelegate
        tableView.dataSource = listViewDataSource
        tableView.registerNib(cellClass: ListCell.self)
    }
}

extension ListViewController: ListViewInput {
    func showItems(_ viewModel: ListViewShowItemsData.ViewModel) {

    }
}

final class ListViewTableDelegate: NSObject, UITableViewDelegate {

}

final class ListViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
