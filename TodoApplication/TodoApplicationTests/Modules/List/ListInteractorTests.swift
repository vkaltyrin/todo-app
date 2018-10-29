@testable import TodoApplication
import XCTest

final class ListInteractorTests: TestCase {
    // MARK: - Subject Under Test
    var interactor: ListInteractor!
    var presenterMock: ListPresenterMock!
    var listStorageMock: ListStorageMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        presenterMock = ListPresenterMock()
        listStorageMock = ListStorageMock()
        interactor = ListInteractorImpl(
            presenter: presenterMock,
            listStorage: listStorageMock
        )
    }
    
    // MARK: - Tests
    
    func testFetchItems_presentLists() {
        // given
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        // when
        interactor.fetchItems()
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowListsCount, 1)
        XCTAssertNil(presenterMock.invokedPresentShowListsParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowListsParameters?.response)
    }
    
    func testDeleteItem_presentUpdatedLists_whenDeleteIsSuccessful() {
        // given
        listStorageMock.stubbedDeleteListCompletionResult = Stub<GeneralResult>.create(.success(()))
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        let request = ListDataFlow.DeleteList.Request(identifier: Identifier.generateUniqueIdentifier())
        // when
        interactor.deleteItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowListsCount, 1)
        XCTAssertNil(presenterMock.invokedPresentShowListsParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowListsParameters?.response)
    }
    
    func testDeleteItem_presentError_whenDeleteIsFailed() {
        // given
        let error = StorageError.cannotDelete
        listStorageMock.stubbedDeleteListCompletionResult = Stub<GeneralResult>.create(.failure(error))
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        let request = ListDataFlow.DeleteList.Request(identifier: Identifier.generateUniqueIdentifier())
        // when
        interactor.deleteItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentErrorCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentErrorParameters?.error, error)
    }
    
    func testUpdateItem_presentUpdatedLists_whenUpdateIsSuccessful() {
        // given
        listStorageMock.stubbedUpdateListCompletionResult = Stub<GeneralResult>.create(.success(()))
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        let request = ListDataFlow.UpdateList.Request(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.updateItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowListsCount, 1)
        XCTAssertNil(presenterMock.invokedPresentShowListsParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowListsParameters?.response)
    }
    
    func testUpdateItem_presentUpdatedLists_whenUpdateIsFailed() {
        // given
        let error = StorageError.cannotUpdate
        listStorageMock.stubbedUpdateListCompletionResult = Stub<GeneralResult>.create(.failure(error))
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        let request = ListDataFlow.UpdateList.Request(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.updateItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentErrorCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentErrorParameters?.error, error)
    }
    
    func testCreateItem_presentUpdatedLists_whenCreateIsSuccessful() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        listStorageMock.stubbedCreateListCompletionResult = Stub<IdentifierResult>.create(.success(identifier))
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        let request = ListDataFlow.CreateList.Request(
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.createItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowListsCount, 1)
        XCTAssertNotNil(presenterMock.invokedPresentShowListsParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowListsParameters?.response)
    }
    
    func testCreateItem_presentUpdatedLists_whenCreateIsFailed() {
        // given
        let error = StorageError.cannotCreate
        listStorageMock.stubbedCreateListCompletionResult = Stub<IdentifierResult>.create(.failure(error))
        listStorageMock.stubbedFetchListsCompletionResult = Stub<ListResult>.create(.success([]))
        let request = ListDataFlow.CreateList.Request(
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.createItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentErrorCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentErrorParameters?.error, error)
    }
    
    func testOpenListActions_presentListActions() {
        // given
        let request = ListDataFlow.OpenListActions.Request(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.openListActions(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentListActionsCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentListActionsParameters?.identifier, request.identifier)
    }
    
    func testOpenListEditing_presentListEditing() {
        // given
        let request = ListDataFlow.OpenListEditing.Request(
            identifier: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.openListEditing(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentListEditingCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentListEditingParameters?.identifier, request.identifier)
    }

}
