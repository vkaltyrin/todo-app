import Foundation

typealias OnFetchTasks = (StorageResult<[Task]>) -> ()
typealias StorageResult<T> = Result<T, StorageError>
typealias OnStorageResult = (StorageResult<Void>) -> ()

protocol TaskStorage: class {
    func fetchTasks(listId: Identifier, _ completion: @escaping OnFetchTasks)

    func deleteTask(taskId: Identifier, _ completion: @escaping OnStorageResult)

    func createTask(_ task: Task, _ completion: @escaping OnStorageResult)

    func updateTask(_ task: Task, _ completion: @escaping OnStorageResult)
}
