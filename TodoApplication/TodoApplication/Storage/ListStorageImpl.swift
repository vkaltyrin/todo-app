import Foundation
import RealmSwift

final class ListStorageImpl: ListStorage {
    // MARK: - Private
    private let queue = DispatchQueue(label: "com.vkaltyrin.ListStorageImpl.queue")

    // MARK: - ListStorage
    func fetchLists(_ completion: @escaping OnFetchLists) {
        queue.async {
            let realm = try? Realm()
            if let lists = realm?.objects(RealmList.self).sorted(
                byKeyPath: "name",
                ascending: true) {
                completion(.success(lists.map { $0.toList() }))
            } else {
                completion(.failure(.cannotFetch))
            }
        }
    }

    func deleteList(listId: Identifier, _ completion: @escaping OnStorageResult) {
        queue.async {
            let realm = try? Realm()
            guard let listForDelete = realm?.objects(RealmList.self).first(where: { list in
                list.identifier == listId
            }) else {
                completion(.failure(.cannotDelete))
                return
            }
            do {
                try realm?.write {
                    realm?.delete(listForDelete)
                }
                completion(.success(()))
            } catch {
                completion(.failure(.internalError))
            }
        }
    }

    func createList(_ list: List, _ completion: @escaping OnStorageResult) {
        queue.async {
            let realm = try? Realm()
            let realmList = list.toRealm()
            do {
                try realm?.write {
                    realm?.add(realmList)
                }
                completion(.success(()))
            } catch {
                completion(.failure(.internalError))
            }
        }
    }

    func updateList(_ list: List, _ completion: @escaping OnStorageResult) {
        queue.async {
            let realm = try? Realm()
            guard let listForUpdate = realm?.objects(RealmList.self).first(where: { realmTask in
                realmTask.identifier == list.identifier
            }) else {
                completion(.failure(.cannotUpdate))
                return
            }
            do {
                try realm?.write {
                    listForUpdate.name = list.name
                    listForUpdate.tasks.append(objectsIn: list.tasks.toRealm())
                }
                completion(.success(()))
            } catch {
                completion(.failure(.internalError))
            }
        }
    }
}
