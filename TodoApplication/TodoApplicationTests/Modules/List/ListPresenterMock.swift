@testable import TodoApplication
import XCTest

final class ListPresenterMock: ListPresenter {
    func presentShowLists(_ response: ListDataFlow.ShowLists.Response) {
        
    }
    
    func presentCreateList(_ response: ListDataFlow.CreateList.Response) {
        
    }
    
    func presentListActions(_ identifier: Identifier) {
        
    }
    
    func presentListEditing(_ identifier: Identifier) {
        
    }
    
    func presentShowList(_ response: ListDataFlow.ShowLists.Response) {
    
    }
    
    func presentError(_ error: StorageError) {
        
    }
    

    

}
