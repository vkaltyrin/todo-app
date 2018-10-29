@testable import TodoApplication
import XCTest

final class ListRouterMock: ListRouter {

    var invokedOpenTasks = false
    var invokedOpenTasksCount = 0
    var invokedOpenTasksParameters: (listIdentifier: String, Void)?
    var invokedOpenTasksParametersList = [(listIdentifier: String, Void)]()

    func openTasks(listIdentifier: String) {
        invokedOpenTasks = true
        invokedOpenTasksCount += 1
        invokedOpenTasksParameters = (listIdentifier, ())
        invokedOpenTasksParametersList.append((listIdentifier, ()))
    }
}
