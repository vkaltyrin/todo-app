@testable import TodoApplication
import XCTest

final class ListStorageMock: ListStorage {

    var invokedFetchLists = false
    var invokedFetchListsCount = 0
    var stubbedFetchListsCompletionResult: (ListResult, Void)?

    func fetchLists(_ completion: @escaping OnFetchLists) {
        invokedFetchLists = true
        invokedFetchListsCount += 1
        if let result = stubbedFetchListsCompletionResult {
            completion(result.0)
        }
    }

    var invokedDeleteList = false
    var invokedDeleteListCount = 0
    var invokedDeleteListParameters: (listId: Identifier, Void)?
    var invokedDeleteListParametersList = [(listId: Identifier, Void)]()
    var stubbedDeleteListCompletionResult: (GeneralResult, Void)?

    func deleteList(listId: Identifier, _ completion: @escaping OnStorageResult) {
        invokedDeleteList = true
        invokedDeleteListCount += 1
        invokedDeleteListParameters = (listId, ())
        invokedDeleteListParametersList.append((listId, ()))
        if let result = stubbedDeleteListCompletionResult {
            completion(result.0)
        }
    }

    var invokedCreateList = false
    var invokedCreateListCount = 0
    var invokedCreateListParameters: (list: List, Void)?
    var invokedCreateListParametersList = [(list: List, Void)]()
    var stubbedCreateListCompletionResult: (GeneralResult, Void)?

    func createList(_ list: List, _ completion: @escaping OnStorageResult) {
        invokedCreateList = true
        invokedCreateListCount += 1
        invokedCreateListParameters = (list, ())
        invokedCreateListParametersList.append((list, ()))
        if let result = stubbedCreateListCompletionResult {
            completion(result.0)
        }
    }

    var invokedUpdateList = false
    var invokedUpdateListCount = 0
    var invokedUpdateListParameters: (task: List, Void)?
    var invokedUpdateListParametersList = [(task: List, Void)]()
    var stubbedUpdateListCompletionResult: (GeneralResult, Void)?

    func updateList(_ task: List, _ completion: @escaping OnStorageResult) {
        invokedUpdateList = true
        invokedUpdateListCount += 1
        invokedUpdateListParameters = (task, ())
        invokedUpdateListParametersList.append((task, ()))
        if let result = stubbedUpdateListCompletionResult {
            completion(result.0)
        }
    }
}