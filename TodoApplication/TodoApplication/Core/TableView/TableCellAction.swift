import Foundation
import UIKit

protocol CellActionable {
    func call(
        action: CellActionType,
        cell: UITableViewCell?,
        indexPath: IndexPath) -> Any?
}

enum CellActionType: Hashable {
    case tap
    case swipeToDelete
    case configure
    case willDisplay

    var key: String {
        return "\(self)"
    }

    var hashValue: Int {
        return key.hashValue
    }
}

final class CellActionParameters<CellType: ConfigurableCell> where CellType: UITableViewCell {
    let viewModel: CellType.ViewModel
    let cell: CellType?
    let indexPath: IndexPath

    init(viewModel: CellType.ViewModel, cell: CellType?, indexPath: IndexPath) {
        self.viewModel = viewModel
        self.cell = cell
        self.indexPath = indexPath
    }
}

enum CellActionFunction<CellType: ConfigurableCell> where CellType: UITableViewCell {
    case void((CellActionParameters<CellType>) -> ())
    case any((CellActionParameters<CellType>) -> Any?)

    func call(parameters: CellActionParameters<CellType>) -> Any? {
        switch self {
        case .void(let function):
            return function(parameters)
        case .any(let function):
            return function(parameters)
        }
    }
}

final class TableCellAction<CellType: ConfigurableCell> where CellType: UITableViewCell {
    let type: CellActionType
    let function: CellActionFunction<CellType>

    init<T>(_ type: CellActionType, function: @escaping (_ parameters: CellActionParameters<CellType>) -> T) {
        self.type = type
        self.function = .any(function)
    }

    func callActionOn(cell: UITableViewCell?, viewModel: CellType.ViewModel, indexPath: IndexPath) -> Any? {
        let parameters = CellActionParameters(viewModel: viewModel, cell: cell as? CellType, indexPath: indexPath)
        return function.call(parameters: parameters)
    }
}
