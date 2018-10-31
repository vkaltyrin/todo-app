import Foundation
import UIKit

protocol CellConfigurator {
    func configure(_ cell: UITableViewCell)

    var reuseIdentifier: String { get }
    var cellType: AnyClass { get }
}

final class TableCell<CellType: ConfigurableCell>: CellConfigurator where CellType: UITableViewCell {

    // MARK: - State

    let viewModel: CellType.ViewModel

    // MARK: - Init

    init(viewModel: CellType.ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - CellConfigurator

    var reuseIdentifier: String {
        return CellType.reuseIdentifier
    }

    var cellType: AnyClass {
        return CellType.self
    }

    func configure(_ cell: UITableViewCell) {

    }

}

final class Section {
    private let cells: [CellConfigurator]

    init(cells: [CellConfigurator]) {
        self.cells = cells
    }

    var numberOfRows: Int {
        return cells.count
    }

    subscript(index: Int) -> CellConfigurator? {
        return cells[safe: index]
    }
}

protocol TableManager: class {
    func reload(_ sections: [Section])
}

final class TableManagerImpl: NSObject {
    // MARK: - Dependencies

    private weak var tableView: UITableView?

    // MARK: - State

    private var sections: [Section] = []

    // MARK: - Init

    init(tableView: UITableView) {
        self.tableView = tableView
    }
}

extension TableManagerImpl: TableManager {
    func reload(_ sections: [Section]) {
        self.sections = sections
        tableView?.reloadData()
    }
}

extension TableManagerImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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

        return cell
    }
}
