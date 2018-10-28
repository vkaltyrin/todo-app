import Foundation

protocol ListStorage: class {
    func fetchLists(_ completion: @escaping OnFetchLists)

    func deleteList(listId: Identifier, _ completion: @escaping OnStorageResult)

    func createList(_ list: List, _ completion: @escaping OnStorageResult)

    func updateList(_ task: List, _ completion: @escaping OnStorageResult)
}
