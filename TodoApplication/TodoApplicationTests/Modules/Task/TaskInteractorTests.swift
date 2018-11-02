@testable import TodoApplication
import XCTest

final class TaskInteractorTests: TestCase {
    // MARK: - Subject Under Test
    var interactor: TaskInteractor!
    var presenterMock: TaskPresenterMock!
    var taskStorageMock: TaskStorageMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        presenterMock = TaskPresenterMock()
        taskStorageMock = TaskStorageMock()
        interactor = TaskInteractorImpl(
            listIdentifier: Identifier.generateUniqueIdentifier(),
            presenter: presenterMock,
            taskStorage: taskStorageMock
        )
    }
    
    // MARK: - Tests
    
    func testFetchItems_presentTasks() {
        // given
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        // when
        interactor.fetchItems()
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowTasksCount, 1)
        XCTAssertNil(presenterMock.invokedPresentShowTasksParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowTasksParameters?.response)
    }
    
    func testFetchItems_presentLoading() {
        // when
        interactor.fetchItems()
        // then
        XCTAssertEqual(presenterMock.invokedPresentLoadingCount, 1)
    }
    
    func testDeleteItem_presentUpdatedTasks_whenDeleteIsSuccessful() {
        // given
        taskStorageMock.stubbedDeleteTaskCompletionResult = Stub<GeneralResult>.create(.success(()))
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        let request = TaskDataFlow.DeleteTask.Request(identifier: Identifier.generateUniqueIdentifier())
        // when
        interactor.deleteItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowTasksCount, 1)
        XCTAssertNil(presenterMock.invokedPresentShowTasksParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowTasksParameters?.response)
    }
    
    func testDeleteItem_presentLoading() {
        // given
        let request = TaskDataFlow.DeleteTask.Request(identifier: Identifier.generateUniqueIdentifier())
        // when
        interactor.deleteItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentLoadingCount, 1)
    }
    
    func testDeleteItem_presentError_whenDeleteIsFailed() {
        // given
        let error = StorageError.cannotDelete
        taskStorageMock.stubbedDeleteTaskCompletionResult = Stub<GeneralResult>.create(.failure(error))
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        let request = TaskDataFlow.DeleteTask.Request(identifier: Identifier.generateUniqueIdentifier())
        // when
        interactor.deleteItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentErrorCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentErrorParameters?.error, error)
    }
    
    func testUpdateItem_presentUpdatedTasks_whenUpdateIsSuccessful() {
        // given
        taskStorageMock.stubbedUpdateTaskCompletionResult = Stub<GeneralResult>.create(.success(()))
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        let request = TaskDataFlow.UpdateTask.Request(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.updateItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowTasksCount, 1)
        XCTAssertNil(presenterMock.invokedPresentShowTasksParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowTasksParameters?.response)
    }
    
    func testUpdateItem_presentLoading() {
        // given
        let request = TaskDataFlow.UpdateTask.Request(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.updateItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentLoadingCount, 1)
    }
    
    func testUpdateItem_presentUpdatedTasks_whenUpdateIsFailed() {
        // given
        let error = StorageError.cannotUpdate
        taskStorageMock.stubbedUpdateTaskCompletionResult = Stub<GeneralResult>.create(.failure(error))
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        let request = TaskDataFlow.UpdateTask.Request(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.updateItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentErrorCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentErrorParameters?.error, error)
    }
    
    func testCreateItem_presentUpdatedTasks_whenCreateIsSuccessful() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        taskStorageMock.stubbedCreateTaskCompletionResult = Stub<IdentifierResult>.create(.success(identifier))
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        let request = TaskDataFlow.CreateTask.Request(
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.createItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentShowTasksCount, 1)
        XCTAssertNotNil(presenterMock.invokedPresentShowTasksParameters?.identifier)
        XCTAssertNotNil(presenterMock.invokedPresentShowTasksParameters?.response)
    }
    
    func testCreate_presentLoading() {
        // given
        let request = TaskDataFlow.CreateTask.Request(
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.createItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentLoadingCount, 1)
    }
    
    func testCreateItem_presentUpdatedTasks_whenCreateIsFailed() {
        // given
        let error = StorageError.cannotCreate
        taskStorageMock.stubbedCreateTaskCompletionResult = Stub<IdentifierResult>.create(.failure(error))
        taskStorageMock.stubbedFetchTasksCompletionResult = Stub<TaskResult>.create(.success([]))
        let request = TaskDataFlow.CreateTask.Request(
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.createItem(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentErrorCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentErrorParameters?.error, error)
    }
    
    func testOpenTaskActions_presentTaskActions() {
        // given
        let request = TaskDataFlow.OpenTaskActions.Request(
            identifier: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.openTaskActions(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentTaskActionsCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentTaskActionsParameters?.identifier, request.identifier)
    }
    
    func testOpenTaskEditing_presentTaskEditing() {
        // given
        let request = TaskDataFlow.OpenTaskEditing.Request(
            identifier: Identifier.generateUniqueIdentifier()
        )
        // when
        interactor.openTaskEditing(request: request)
        // then
        XCTAssertEqual(presenterMock.invokedPresentTaskEditingCount, 1)
        XCTAssertEqual(presenterMock.invokedPresentTaskEditingParameters?.identifier, request.identifier)
    }
    
}
