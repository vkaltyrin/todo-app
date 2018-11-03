import Foundation
import RealmSwift

final class ListStorageImpl: ListStorage {
    // MARK: - Private
    private let queue = DispatchQueue(label: "com.vkaltyrin.ListStorageImpl.queue")

    // MARK: - ListStorage
    func fetchLists(_ completion: @escaping OnFetchLists) {
        queue.async {
            let result: ListResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            let realm = try? Realm()

            // There is an issue in Realm Cocoa regarded wrong sorting order for strings
            // https://github.com/realm/realm-cocoa/issues/3417
            if let realmLists = realm?.objects(RealmList.self) {
                let lists = realmLists.map { $0.toList() }.sorted(by: { lhs, rhs -> Bool in
                    lhs.name < rhs.name
                })
                result = .success(lists)
            } else {
                result = .failure(.cannotFetch)
            }
        }
    }

    func deleteList(listId: Identifier, _ completion: @escaping OnStorageResult) {
        queue.async {
            let result: GeneralResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            let realm = try? Realm()
            guard let listForDelete = realm?.objects(RealmList.self).first(where: { list in
                list.identifier == listId
            }) else {
                result = .failure(.cannotDelete)
                return
            }
            do {
                try realm?.write {
                    realm?.delete(listForDelete)
                }
                result = .success(())
            } catch {
                result = .failure(.internalError)
            }
        }
    }

    func createList(_ list: List, _ completion: @escaping OnStorageIndentifier) {
        queue.async {
            let result: StorageResult<Identifier>
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            let realm = try? Realm()
            let realmList = list.toRealm()
            do {
                try realm?.write {
                    realm?.add(realmList)
                }
                result = .success(realmList.identifier)
            } catch {
                result = .failure(.internalError)
            }
        }
    }

    func updateList(listId: Identifier, name: String, _ completion: @escaping OnStorageResult) {
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
                result = .failure(.cannotUpdate)
                return
            }
            do {
                try realm?.write {
                    listForUpdate.name = name
                }
                result = .success(())
            } catch {
                result = .failure(.internalError)
            }
        }
    }
}
