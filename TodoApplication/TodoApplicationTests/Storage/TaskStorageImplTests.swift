@testable import TodoApplication
import XCTest

final class TaskStorageImplTests: StorageTestCase {
    
    // MARK: - Subject under test
    var storage: TaskStorage!
    
    // MARK: - State
    var tasks: [Task] = []
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        storage = TaskStorageImpl()
        createTasks()
    }
    
    // MARK: - Tear Down
    override func tearDown() {
        super.tearDown()
        storage = nil
    }
    
    // MARK: - Tests
    func testFetchTasks_returnTasks_sortedDescendingByCreationDate() {
        // given
        var receivedTasks: [Task] = []
        let response = expectation(description: "wait for return")
        
        // when
        storage.fetchTasks(listId: TestData.listIdentifier) { result in
            result.onSuccess { tasks in
                receivedTasks = tasks
                response.fulfill()
            }
            result.onFailure { error in
                XCTFail("fetchTasks should not return a error \(error)")
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        guard receivedTasks.count == tasks.count else {
            XCTFail("fetchTasks should return tasks")
            return
        }
        XCTAssertEqual(receivedTasks[0], TestData.buyTeaTask)
        XCTAssertEqual(receivedTasks[1], TestData.runMarathonTask)
    }
    
    func testFetchTask_returnEmptyList_withWrongListIdentifier() {
        // given
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        var receivedTasks: [Task] = []
        
        // when
        storage.fetchTasks(listId: TestData.wrongIdentifier) { result in
            result.onSuccess { result in
                receivedTasks = result
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        XCTAssertEqual(receivedTasks.count, 0)
        XCTAssertNil(receivedError)
    }
    
    func testDeleteTask_deleteTask_withSuccess() {
        // given
        let identifier = TestData.runMarathonTaskIdentifier
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.deleteTask(taskId: identifier) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        XCTAssertNil(receivedError)
    }
    
    func testDeleteTask_returnError_withWrongTaskIdentifier() {
        // given
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.deleteTask(taskId: TestData.wrongIdentifier) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        guard let error = receivedError else {
            XCTFail("deleteTask should return an error")
            return
        }
        
        switch error {
        case .cannotDelete:
            break
        default:
            XCTFail("deleteTask should return corrent error")
        }
    }
    
    func testCreateTask_createTask_withSuccess() {
        // given
        let task = TestData.makeCoffeeTask
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.createTask(listId: TestData.listIdentifier, task: task) { result in
            result.onSuccess { _ in
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        XCTAssertNil(receivedError)
    }
    
    func testUpdateTaskName_update_withSuccess() {
        // given
        let task = TestData.writeTestsTask
        var receivedError: StorageError?
        let name = Identifier.generateUniqueIdentifier()
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateTask(taskId: task.identifier ?? "", name: name) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        XCTAssertNil(receivedError)
    }
    
    func testUpdateTaskIsDone_update_withSuccess() {
        // given
        let task = TestData.writeTestsTask
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateTask(taskId: task.identifier ?? "", isDone: true) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        XCTAssertNil(receivedError)
    }
    
    func testUpdateTaskName_returnError_withWrongTaskIdentifier() {
        // given
        let task = TestData.makeCoffeeTask
        var receivedError: StorageError?
        let name = Identifier.generateUniqueIdentifier()
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateTask(taskId: task.identifier ?? "", name: name) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        guard let error = receivedError else {
            XCTFail("updateTask should return an error")
            return
        }
        
        switch error {
        case .cannotUpdate:
            break
        default:
            XCTFail("updateTask should return corrent error")
        }
    }
    
    func testUpdateTaskIsDone_returnError_withWrongTaskIdentifier() {
        // given
        let task = TestData.makeCoffeeTask
        var receivedError: StorageError?
        let name = Identifier.generateUniqueIdentifier()
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateTask(taskId: task.identifier ?? "", name: name) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        guard let error = receivedError else {
            XCTFail("updateTask should return an error")
            return
        }
        
        switch error {
        case .cannotUpdate:
            break
        default:
            XCTFail("updateTask should return corrent error")
        }
    }
    
    // MARK: - Private
    private func createTasks() {
        let tasks = [TestData.runMarathonTask, TestData.buyTeaTask]
        let list = List(
            name: "Todo list",
            tasks: tasks,
            identifier: TestData.listIdentifier
        )
        let listStorage = ListStorageImpl()
        let createListExpectation = expectation(description: "wait for return")
        listStorage.createList(list) { result in
            createListExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        self.tasks = tasks
    }
}

extension TaskStorageImplTests {
    struct TestData {
        static let listIdentifier = Identifier.generateUniqueIdentifier()
        static let wrongIdentifier = Identifier.generateUniqueIdentifier()
        static let runMarathonTaskIdentifier = Identifier.generateUniqueIdentifier()
        static let runMarathonTask = Task(
            name: "Run a marathon",
            identifier: runMarathonTaskIdentifier,
            creationDate: Date(timeIntervalSince1970: 0)
        )
        static let buyTeaTask = Task(
            name: "Buy a pu-erh tea",
            identifier: "ID-2",
            creationDate: Date(timeIntervalSince1970: 1)
        )
        static let writeTestsTask = Task(
            name: "Write tests",
            identifier: runMarathonTaskIdentifier,
            creationDate: Date(timeIntervalSince1970: 2)
        )
        static let makeCoffeeTask = Task(
            name: "Make a coffee",
            identifier: "ID",
            creationDate: Date(timeIntervalSince1970: 3)
        )
        static let nonExistingTask = Task(
            name: "Non existing",
            identifier: Identifier.generateUniqueIdentifier(),
            creationDate: Date(timeIntervalSince1970: 4)
        )
    }
}
