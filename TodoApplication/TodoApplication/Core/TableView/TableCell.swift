import Foundation
import UIKit

final class TableCell<CellType: ConfigurableCell>: CellConfigurator where CellType: UITableViewCell {
    // MARK: - State

    let viewModel: CellType.ViewModel

    // MARK: - Private state
    private var actions = [CellActionType: [TableCellAction<CellType>]]()

    // MARK: - Init

    init(viewModel: CellType.ViewModel, actions: [TableCellAction<CellType>] = []) {
        self.viewModel = viewModel
        actions.forEach { on($0) }
    }

    // MARK: - CellConfigurator

    var reuseIdentifier: String {
        return CellType.reuseIdentifier
    }

    var cellType: AnyClass {
        return CellType.self
    }

    func configure(_ cell: UITableViewCell) {
        (cell as? CellType)?.configure(viewModel)
    }

    // MARK: - Perform actions

    @discardableResult
    func on(_ action: TableCellAction<CellType>) -> Self {

        if actions[action.type] == nil {
            actions[action.type] = [TableCellAction<CellType>]()
        }
        actions[action.type]?.append(action)

        return self
    }

    @discardableResult
    func on<T>(
        _ type: CellActionType,
        function: @escaping (_ options: CellActionParameters<CellType>) -> T) -> Self {
        return on(TableCellAction<CellType>(type, function: function))
    }
}

extension TableCell: CellActionable {
    func call(action: CellActionType, cell: UITableViewCell?, indexPath: IndexPath) -> Any? {
        let results = actions[action]?.compactMap {
            $0.callActionOn(cell: cell, viewModel: viewModel, indexPath: indexPath)
        }
        return results?.last
    }
}
