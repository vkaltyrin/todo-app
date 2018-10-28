import Foundation
import RealmSwift

enum StorageError {
    case cannotCreate
    case cannotFetch
    case cannotDelete
    case cannotUpdate
}

class RealmTask: Object {
    @objc dynamic var identifier: Identifier?
    @objc dynamic var name = ""
    @objc dynamic var status = Task.Status.undone
    @objc dynamic var creationDate = Date()
}

extension RealmTask {
    func toTask() -> Task {
        return Task(
            identifier: identifier,
            name: name,
            status: status,
            creationDate: creationDate
        )
    }
}

extension Task {
    func toRealm() -> RealmTask {
        let result = RealmTask()
        result.identifier = identifier
        result.name = name
        result.status = status
        result.creationDate = creationDate
        return result
    }
}

final class TaskStorageImpl: TaskStorage {

    private let queue = DispatchQueue(label: "com.vkaltyrin.TaskStorageImpl.queue")

    func fetchTasks(listId: Identifier, _ completion: @escaping OnFetchTasks) {
        queue.async {
            let realm = try? Realm()
            if let tasks = realm?.objects(RealmTask.self).sorted(
                byKeyPath: "creationDate",
                ascending: false) {
                completion(.success(tasks.map { $0.toTask() }))
            } else {
                completion(.failure(.cannotFetch))
            }
        }
    }

    func deleteTask(taskId: Identifier, _ completion: @escaping OnStorageResult) {
        queue.async {
            let realm = try? Realm()
            guard let taskForDelete = realm?.objects(RealmTask.self).first(where: { task in
                task.identifier == taskId
            }) else {
                completion(.failure(.cannotDelete))
                return
            }
            do {
                try realm?.write {
                    realm?.delete(taskForDelete)
                }
                completion(.success(()))
            } catch {
                completion(.failure(.cannotDelete))
            }
        }
    }

    func createTask(_ task: Task, _ completion: @escaping OnStorageResult) {
        queue.async {
            let realm = try? Realm()
            let realmTask = task.toRealm()
            do {
                try realm?.write {
                    realm?.add(realmTask)
                }
                completion(.success(()))
            } catch {
                completion(.failure(.cannotCreate))
            }
        }
    }

    func updateTask(_ task: Task, _ completion: @escaping OnStorageResult) {
        queue.async {
            let realm = try? Realm()
            guard let taskForUpdate = realm?.objects(RealmTask.self).first(where: { realmTask in
                realmTask.identifier == task.identifier
            }) else {
                completion(.failure(.cannotUpdate))
                return
            }
            do {
                try realm?.write {
                    taskForUpdate.name = task.name
                    taskForUpdate.status = task.status
                    taskForUpdate.creationDate = task.creationDate
                }
                completion(.success(()))
            } catch {
                completion(.failure(.cannotUpdate))
            }
        }
    }
}
