@testable import TodoApplication
import XCTest

class TaskStorageImplTests: StorageTestCase {
    
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
    
    func testFetchTask_returnError_withWrongListIdentifier() {
        // given
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.fetchTasks(listId: TestData.wrongIdentifier) { result in
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
        guard let error = receivedError else {
            XCTFail("fetchTask should return an error")
            return
        }
        
        switch error {
        case .cannotFetch:
            break
        default:
            XCTFail("fetchTask should return corrent error")
        }
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
        storage.createTask(task) { result in
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
    
    func testUpdateTask_updateTask_withSuccess() {
        // given
        let task = TestData.writeTestsTask
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateTask(task) { result in
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
    
    func testUpdateTask_returnError_withWrongTaskIdentifier() {
        // given
        let task = TestData.makeCoffeeTask
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateTask(task) { result in
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
        let list = List(identifier: TestData.listIdentifier, name: "Todo list", tasks: tasks)
        
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
        static let listIdentifier = "List-ID"
        static let wrongIdentifier = "wrongIdentifier"
        static let runMarathonTaskIdentifier = "ID-1"
        static let runMarathonTask = Task(
            identifier: runMarathonTaskIdentifier,
            name: "Run a marathon",
            status: .undone,
            creationDate: Date(timeIntervalSince1970: 0)
        )
        static let buyTeaTask = Task(
            identifier: "ID-2",
            name: "Buy a pu-erh tea",
            status: .done,
            creationDate: Date(timeIntervalSince1970: 1)
        )
        static let writeTestsTask = Task(
            identifier: runMarathonTaskIdentifier,
            name: "Write tests",
            status: .done,
            creationDate: Date(timeIntervalSince1970: 2)
        )
        static let makeCoffeeTask = Task(
            identifier: "ID",
            name: "Make a coffee",
            status: .done,
            creationDate: Date(timeIntervalSince1970: 3)
        )
        static let nonExistingTask = Task(
            identifier: "nonExistingTask ID",
            name: "Non existing",
            status: .done,
            creationDate: Date(timeIntervalSince1970: 4)
        )
    }
}
