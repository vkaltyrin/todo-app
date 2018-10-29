@testable import TodoApplication
import XCTest

final class TaskStorageMock: TaskStorage {


    var invokedFetchTasks = false
    var invokedFetchTasksCount = 0
    var invokedFetchTasksParameters: (listId: Identifier, Void)?
    var invokedFetchTasksParametersList = [(listId: Identifier, Void)]()
    var stubbedFetchTasksCompletionResult: (TaskResult, Void)?

    func fetchTasks(listId: Identifier, _ completion: @escaping OnFetchTasks) {
        invokedFetchTasks = true
        invokedFetchTasksCount += 1
        invokedFetchTasksParameters = (listId, ())
        invokedFetchTasksParametersList.append((listId, ()))
        if let result = stubbedFetchTasksCompletionResult {
            completion(result.0)
        }
    }

    var invokedDeleteTask = false
    var invokedDeleteTaskCount = 0
    var invokedDeleteTaskParameters: (taskId: Identifier, Void)?
    var invokedDeleteTaskParametersList = [(taskId: Identifier, Void)]()
    var stubbedDeleteTaskCompletionResult: (GeneralResult, Void)?

    func deleteTask(taskId: Identifier, _ completion: @escaping OnStorageResult) {
        invokedDeleteTask = true
        invokedDeleteTaskCount += 1
        invokedDeleteTaskParameters = (taskId, ())
        invokedDeleteTaskParametersList.append((taskId, ()))
        if let result = stubbedDeleteTaskCompletionResult {
            completion(result.0)
        }
    }

    var invokedCreateTask = false
    var invokedCreateTaskCount = 0
    var invokedCreateTaskParameters: (listId: Identifier, task: Task)?
    var invokedCreateTaskParametersList = [(listId: Identifier, task: Task)]()
    var stubbedCreateTaskCompletionResult: (IdentifierResult, Void)?

    func createTask(listId: Identifier, task: Task, _ completion: @escaping OnStorageIndentifier) {
        invokedCreateTask = true
        invokedCreateTaskCount += 1
        invokedCreateTaskParameters = (listId, task)
        invokedCreateTaskParametersList.append((listId, task))
        if let result = stubbedCreateTaskCompletionResult {
            completion(result.0)
        }
    }

    var invokedUpdateTask = false
    var invokedUpdateTaskCount = 0
    var invokedUpdateTaskParameters: (taskId: Identifier, name: String)?
    var invokedUpdateTaskParametersList = [(taskId: Identifier, name: String)]()
    var stubbedUpdateTaskCompletionResult: (GeneralResult, Void)?

    func updateTask(taskId: Identifier, name: String, _ completion: @escaping OnStorageResult) {
        invokedUpdateTask = true
        invokedUpdateTaskCount += 1
        invokedUpdateTaskParameters = (taskId, name)
        invokedUpdateTaskParametersList.append((taskId, name))
        if let result = stubbedUpdateTaskCompletionResult {
            completion(result.0)
        }
    }
}
