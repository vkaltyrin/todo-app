import Foundation

protocol TaskStorage: class {
    func fetchTasks(listId: Identifier, _ completion: @escaping OnFetchTasks)

    func deleteTask(taskId: Identifier, _ completion: @escaping OnStorageResult)

    func createTask(listId: Identifier, task: Task, _ completion: @escaping OnStorageIndentifier)

    func updateTask(taskId: Identifier, name: String, _ completion: @escaping OnStorageResult)

    func updateTask(taskId: Identifier, isDone: Bool, _ completion: @escaping OnStorageResult)
}
