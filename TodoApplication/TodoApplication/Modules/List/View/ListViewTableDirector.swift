import Foundation
import UIKit

final class ListViewTableDirector: NSObject, TableDirector {

    weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self

            tableView?.registerNib(cellClass: ListCell.self)
        }
    }

    // MARK: - TableDirector

    func reload() {
        tableView?.reloadData()
    }

    // MARK: - State

    var items: [ListViewModel] = [] {
        didSet {
            reload()
        }
    }

    var onListTap: ((Identifier) -> ())?
    var onCellTextDidEndEditing: ((_ identifier: Identifier, _ text: String) -> ())?
    var onDeleteTap: ((_ identifier: Identifier) -> ())?

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard let viewModel = items[safe: indexPath.row] else {
            return
        }

        onListTap?(viewModel.identifier)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let viewModel = items[safe: indexPath.row] else {
                return
            }
            onDeleteTap?(viewModel.identifier)
        default:
            break
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(type: ListCell.self, indexPath: indexPath) else {
            assertionFailure("Couldn't dequeue reusable cell")
            return UITableViewCell()
        }
        guard let viewModel = items[safe: indexPath.row] else {
            return cell
        }

        cell.configure(viewModel)
        cell.onTextDidEndEditing = { [weak self] text in
            self?.onCellTextDidEndEditing?(viewModel.identifier, text)
        }

        return cell
    }
}
