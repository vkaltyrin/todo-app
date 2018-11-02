@testable import TodoApplication
import XCTest

final class TableManagerMock<T>: TableManager {

    var invokedSetTableView = false
    var invokedSetTableViewCount = 0
    var invokedSetTableViewParameters: (tableView: UITableView, Void)?
    var invokedSetTableViewParametersList = [(tableView: UITableView, Void)]()

    func setTableView(_ tableView: UITableView) {
        invokedSetTableView = true
        invokedSetTableViewCount += 1
        invokedSetTableViewParameters = (tableView, ())
        invokedSetTableViewParametersList.append((tableView, ()))
    }

    var invokedReload = false
    var invokedReloadCount = 0
    var invokedReloadParameters: (sections: [TableSection], Void)?
    var invokedReloadParametersList = [(sections: [TableSection], Void)]()

    func reload(_ sections: [TableSection]) {
        invokedReload = true
        invokedReloadCount += 1
        invokedReloadParameters = (sections, ())
        invokedReloadParametersList.append((sections, ()))
    }

    var invokedFocusOn = false
    var invokedFocusOnCount = 0
    var invokedFocusOnParameters: (sectionIndex: Int, Void)?
    var invokedFocusOnParametersList = [(sectionIndex: Int, Void)]()
    var stubbedFocusOnPredicateResult: (T, Void)?

    func focusOn<T>(sectionIndex: Int, _ predicate: (T) -> Bool) where T: CellConfigurator {
        invokedFocusOn = true
        invokedFocusOnCount += 1
        invokedFocusOnParameters = (sectionIndex, ())
        invokedFocusOnParametersList.append((sectionIndex, ()))
        if let result = stubbedFocusOnPredicateResult?.0 as? T  {
            _ = predicate(result)
        }
    }
}
