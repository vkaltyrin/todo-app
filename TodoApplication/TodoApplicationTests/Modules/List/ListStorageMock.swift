@testable import TodoApplication
import XCTest

final class ListStorageMock: ListStorage {
    func createList(_ list: List, _ completion: @escaping OnStorageResult) {
        
    }
    
    func fetchLists(_ completion: @escaping OnFetchLists) {
        
    }
    
    func deleteList(listId: Identifier, _ completion: @escaping OnStorageResult) {
        
    }
    
    func updateList(listId: Identifier, name: String, _ completion: @escaping OnStorageResult) {
        
    }

    

    

}
