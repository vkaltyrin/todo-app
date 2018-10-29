import Foundation
import RealmSwift

final class TaskStorageImpl: TaskStorage {

    // MARK: - Private
    private let queue = DispatchQueue(label: "com.vkaltyrin.TaskStorageImpl.queue")

    // MARK: - TaskStorage
    func fetchTasks(listId: Identifier, _ completion: @escaping OnFetchTasks) {
        queue.async {
            let result: TaskResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            let realm = try? Realm()
            let tasks = realm?.objects(RealmTask.self)
                .sorted(byKeyPath: "creationDate", ascending: false)
                .filter { $0.owner.first?.identifier == listId } ?? []

            if !tasks.isEmpty {
                result = .success(tasks.map { $0.toTask() })
            } else {
                result = .failure(.cannotFetch)
            }
        }
    }

    func deleteTask(taskId: Identifier, _ completion: @escaping OnStorageResult) {
        queue.async {
            let result: GeneralResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            let realm = try? Realm()
            guard let taskForDelete = realm?.objects(RealmTask.self).first(where: { task in
                task.identifier == taskId
            }) else {
                result = .failure(.cannotDelete)
                return
            }
            do {
                try realm?.write {
                    realm?.delete(taskForDelete)
                }
                result = .success(())
            } catch {
                result = .failure(.internalError)
            }
        }
    }

    func createTask(listId: Identifier, task: Task, _ completion: @escaping OnStorageResult) {
        queue.async {
            let result: GeneralResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            let realm = try? Realm()
            guard let listForUpdate = realm?.objects(RealmList.self).first(where: { realmTask in
                realmTask.identifier == listId
            }) else {
                result = .failure(.cannotCreate)
                return
            }

            do {
                let realmTask = task.toRealm()
                try realm?.write {
                    listForUpdate.tasks.append(realmTask)
                }
                result = .success(())
            } catch {
                result = .failure(.internalError)
            }
        }
    }

    func updateTask(task: Task, _ completion: @escaping OnStorageResult) {
        queue.async {
            let result: GeneralResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            let realm = try? Realm()
            guard let taskForUpdate = realm?.objects(RealmTask.self).first(where: { realmTask in
                realmTask.identifier == task.identifier
            }) else {
                result = .failure(.cannotUpdate)
                return
            }
            do {
                try realm?.write {
                    taskForUpdate.name = task.name
                    taskForUpdate.status = task.status
                    taskForUpdate.creationDate = task.creationDate
                }
                result = .success(())
            } catch {
                result = .failure(.internalError)
            }
        }
    }
}
