@testable import TodoApplication
import XCTest

final class TaskPresenterMock: TaskPresenter {

    var invokedPresentShowTasks = false
    var invokedPresentShowTasksCount = 0
    var invokedPresentShowTasksParameters: (response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?)?
    var invokedPresentShowTasksParametersList = [(response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?)]()

    func presentShowTasks(_ response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?) {
        invokedPresentShowTasks = true
        invokedPresentShowTasksCount += 1
        invokedPresentShowTasksParameters = (response, identifier)
        invokedPresentShowTasksParametersList.append((response, identifier))
    }

    var invokedPresentError = false
    var invokedPresentErrorCount = 0
    var invokedPresentErrorParameters: (error: StorageError, Void)?
    var invokedPresentErrorParametersList = [(error: StorageError, Void)]()

    func presentError(_ error: StorageError) {
        invokedPresentError = true
        invokedPresentErrorCount += 1
        invokedPresentErrorParameters = (error, ())
        invokedPresentErrorParametersList.append((error, ()))
    }

    var invokedPresentTaskActions = false
    var invokedPresentTaskActionsCount = 0
    var invokedPresentTaskActionsParameters: (identifier: Identifier, Void)?
    var invokedPresentTaskActionsParametersList = [(identifier: Identifier, Void)]()

    func presentTaskActions(_ identifier: Identifier) {
        invokedPresentTaskActions = true
        invokedPresentTaskActionsCount += 1
        invokedPresentTaskActionsParameters = (identifier, ())
        invokedPresentTaskActionsParametersList.append((identifier, ()))
    }

    var invokedPresentTaskEditing = false
    var invokedPresentTaskEditingCount = 0
    var invokedPresentTaskEditingParameters: (identifier: Identifier, Void)?
    var invokedPresentTaskEditingParametersList = [(identifier: Identifier, Void)]()

    func presentTaskEditing(_ identifier: Identifier) {
        invokedPresentTaskEditing = true
        invokedPresentTaskEditingCount += 1
        invokedPresentTaskEditingParameters = (identifier, ())
        invokedPresentTaskEditingParametersList.append((identifier, ()))
    }
}
