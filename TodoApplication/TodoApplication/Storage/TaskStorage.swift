import Foundation

typealias OnFetchTasks = (Result<[Task]>) -> ()

protocol TaskStorage: class {
    func fetchTasks(listId: Identifier, _ completion: @escaping OnFetchTasks)

    func deleteTask(taskId: Identifier, _ completion: @escaping OnSuccess)

    func createTask(_ task: Task, _ completion: @escaping OnSuccess)

    func updateTask(_ task: Task, _ completion: @escaping OnSuccess)
}
