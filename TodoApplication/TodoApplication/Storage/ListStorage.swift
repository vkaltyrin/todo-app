import Foundation

typealias OnFetchLists = (Result<[List]>) -> ()

protocol ListStorage: class {
    func fetchLists(_ completion: @escaping OnFetchLists)

    func deleteList(listId: Identifier, _ completion: @escaping OnSuccess)

    func createList(_ list: List, _ completion: @escaping OnSuccess)

    func updateList(_ task: List, _ completion: @escaping OnSuccess)
}
