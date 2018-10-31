import Foundation
import UIKit

protocol TableManager: class {
    func reload(_ sections: [TableSection])
}

final class TableManagerImpl: NSObject {
    // MARK: - Dependencies

    private weak var tableView: UITableView?

    // MARK: - State

    private var sections: [TableSection] = []

    // MARK: - Init

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    // MARK: - Private

    @discardableResult
    private func call(action: CellActionType, cell: UITableViewCell?, indexPath: IndexPath) -> Any? {
        let function = sections[safe: indexPath.section]?[indexPath.row]
        return function?.call(action: action, cell: cell, indexPath: indexPath)
    }
}

extension TableManagerImpl: TableManager {
    func reload(_ sections: [TableSection]) {
        self.sections = sections
        tableView?.reloadData()
    }
}

extension TableManagerImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        call(action: .tap, cell: cell, indexPath: indexPath)
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        if call(action: .canDelete, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath) as? Bool ?? false {
            return UITableViewCell.EditingStyle.delete
        }

        return UITableViewCell.EditingStyle.none
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            call(action: .swipeToDelete, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        call(action: .willDisplay, cell: cell, indexPath: indexPath)
    }
}

extension TableManagerImpl: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[safe: section]?.numberOfRows ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = sections[safe: indexPath.section]
        guard let cellConfigurator = section?[indexPath.row] else {
            assertionFailure("Row does not exist")
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellConfigurator.reuseIdentifier,
            for: indexPath
        )

        cellConfigurator.configure(cell)
        call(action: .configure, cell: cell, indexPath: indexPath)

        return cell
    }
}
