@testable import TodoApplication
import XCTest

final class ListRouterMock: ListRouter {

    var invokedOpenTasks = false
    var invokedOpenTasksCount = 0
    var invokedOpenTasksParameters: (listIdentifier: String, name: String)?
    var invokedOpenTasksParametersList = [(listIdentifier: String, name: String)]()

    func openTasks(listIdentifier: String, name: String) {
        invokedOpenTasks = true
        invokedOpenTasksCount += 1
        invokedOpenTasksParameters = (listIdentifier, name)
        invokedOpenTasksParametersList.append((listIdentifier, name))
    }
}
