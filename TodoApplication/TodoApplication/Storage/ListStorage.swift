import Foundation

protocol ListStorage: class {
    func fetchLists(_ completion: @escaping OnFetchLists)

    func deleteList(listId: Identifier, _ completion: @escaping OnStorageResult)

    func createList(_ list: List, _ completion: @escaping OnStorageIndentifier)

    func updateList(listId: Identifier, name: String, _ completion: @escaping OnStorageResult)
}
