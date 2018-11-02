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

    var invokedUpdateTaskTaskIdName = false
    var invokedUpdateTaskTaskIdNameCount = 0
    var invokedUpdateTaskTaskIdNameParameters: (taskId: Identifier, name: String)?
    var invokedUpdateTaskTaskIdNameParametersList = [(taskId: Identifier, name: String)]()
    var stubbedUpdateTaskTaskIdNameCompletionResult: (GeneralResult, Void)?

    func updateTask(taskId: Identifier, name: String, _ completion: @escaping OnStorageResult) {
        invokedUpdateTaskTaskIdName = true
        invokedUpdateTaskTaskIdNameCount += 1
        invokedUpdateTaskTaskIdNameParameters = (taskId, name)
        invokedUpdateTaskTaskIdNameParametersList.append((taskId, name))
        if let result = stubbedUpdateTaskTaskIdNameCompletionResult {
            completion(result.0)
        }
    }

    var invokedUpdateTaskTaskIdIsDone = false
    var invokedUpdateTaskTaskIdIsDoneCount = 0
    var invokedUpdateTaskTaskIdIsDoneParameters: (taskId: Identifier, isDone: Bool)?
    var invokedUpdateTaskTaskIdIsDoneParametersList = [(taskId: Identifier, isDone: Bool)]()
    var stubbedUpdateTaskTaskIdIsDoneCompletionResult: (GeneralResult, Void)?

    func updateTask(taskId: Identifier, isDone: Bool, _ completion: @escaping OnStorageResult) {
        invokedUpdateTaskTaskIdIsDone = true
        invokedUpdateTaskTaskIdIsDoneCount += 1
        invokedUpdateTaskTaskIdIsDoneParameters = (taskId, isDone)
        invokedUpdateTaskTaskIdIsDoneParametersList.append((taskId, isDone))
        if let result = stubbedUpdateTaskTaskIdIsDoneCompletionResult {
            completion(result.0)
        }
    }
}
