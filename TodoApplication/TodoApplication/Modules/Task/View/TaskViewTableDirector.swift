import Foundation
import UIKit

protocol TaskViewTableDirector: TableDirector {
    var items: [TaskViewModel] { get set }

    var onTaskTap: ((Identifier) -> ())? { get set }
    var onCellTextDidEndEditing: ((TaskViewModel) -> ())? { get set }
}

final class TaskViewTableDirectorImpl: NSObject, UITableViewDelegate, UITableViewDataSource, TaskViewTableDirector {

    // MARK: - State
    private weak var tableView: UITableView?

    // MARK: - State
    var items: [TaskViewModel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    // MARK: - TaskViewTableDirector
    func setup(with tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerNib(cellClass: TaskCell.self)
        tableView.allowsMultipleSelection = true

        self.tableView = tableView
    }

    func focusOnCell(_ identifier: Identifier) {
        guard let row = items.firstIndex(where: { $0.identifier == identifier }) else {
            return
        }
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView?.cellForRow(at: indexPath) as? TaskCell
        cell?.focus()
    }

    var onTaskTap: ((Identifier) -> ())?
    var onCellTextDidEndEditing: ((TaskViewModel) -> ())?
    var onDeleteTap: ((_ identifier: Identifier) -> ())?

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard let viewModel = items[safe: indexPath.row] else {
            return
        }

        onTaskTap?(viewModel.identifier)
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
        guard let cell = tableView.dequeueReusableCell(type: TaskCell.self, indexPath: indexPath) else {
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
