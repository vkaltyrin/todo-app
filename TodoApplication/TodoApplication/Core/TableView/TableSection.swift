import Foundation
import UIKit

final class TableSection {
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
