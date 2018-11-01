import Foundation
import UIKit

final class TableSection {
    private(set) var cells: [CellConfigurator]

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
