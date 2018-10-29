import Foundation
import UIKit

protocol ListViewTableDirector: TableDirector {
    var items: [ListViewModel] { get set }

    var onListTap: ((ListViewModel) -> ())? { get set }
    var onCellTextDidEndEditing: ((ListViewModel) -> ())? { get set }
}

final class ListViewTableDirectorImpl: NSObject, UITableViewDelegate, UITableViewDataSource, ListViewTableDirector {
    // MARK: - State
    private weak var tableView: UITableView?

    // MARK: - State
    var items: [ListViewModel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    // MARK: - ListViewTableDirector
    func setup(with tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerNib(cellClass: ListCell.self)
        tableView.allowsMultipleSelection = true

        self.tableView = tableView
    }

    func focusOnCell(_ identifier: Identifier) {
        guard let row = items.firstIndex(where: { $0.identifier == identifier }) else {
            return
        }
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView?.cellForRow(at: indexPath) as? ListCell
        cell?.focus()
    }

    var onListTap: ((ListViewModel) -> ())?
    var onCellTextDidEndEditing: ((ListViewModel) -> ())?
    var onDeleteTap: ((_ identifier: Identifier) -> ())?

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard let viewModel = items[safe: indexPath.row] else {
            return
        }

        onListTap?(viewModel)
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
        cell.setAccessibilityIdentifierIndex(index: indexPath.row)
        cell.onTextDidEndEditing = { [weak self] text in
            self?.onCellTextDidEndEditing?(viewModel)
        }

        return cell
    }
}
