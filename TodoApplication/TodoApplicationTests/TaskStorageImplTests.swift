@testable import TodoApplication
import XCTest

class TaskStorageImplTests: TestCase {
    
    // MARK: - Subject under test
    var storage: TaskStorage!
    
    // MARK: - State
    var tasks: [Task] = []
    
    // MARK: - Set Up
    
    override func setUp() {
        super.setUp()
        resetStorageState()
        createTasks()
    }
    
    // MARK: - Tear Down
    
    override func tearDown() {
        super.tearDown()
        storage = nil
    }
    
    // MARK: - Tests
    
    func testFetchTasks_returnTasks_withSuccess() {
        // given
        let expectedTasks = tasks
        var receivedError: Error?
        var receivedTasks: [Task] = []
        let response = expectation(description: "wait for return")
        
        // when
        storage.fetchTasks(listId: TestData.listIdentifier) { result in
            result.onSuccess { tasks in
                receivedTasks = tasks
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        XCTAssertEqual(receivedTasks, expectedTasks)
        XCTAssertNil(receivedError)
    }
    
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
    
    func testDeleteTask_deleteTask_withSuccess() {
        // given
        let identifier = TestData.runMarathonTaskIdentifier
        var receivedError: Error?
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
    
    func testCreateTask_createTask_withSuccess() {
        // given
        let task = TestData.makeCoffeeTask
        var receivedError: Error?
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
        var receivedError: Error?
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
    
    // MARK: - Private
    
    private func resetStorageState() {
        storage = TaskStorageImpl()
        deleteAllTasks()
    }
    
    private func deleteAllTasks() {
        let fetchTasksExpectation = expectation(description: "wait for return")
        var receivedTasks: [Task] = []
        storage.fetchTasks(listId: TestData.listIdentifier) { result in
            result.onSuccess { tasks in
                receivedTasks = tasks
            }
            fetchTasksExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        receivedTasks.forEach { [weak self] task in
            if let identifier = task.identifier {
                let deleteTaskExpectation = expectation(description: "wait for return")
                self?.storage.deleteTask(taskId: identifier) { _ in
                    deleteTaskExpectation.fulfill()
                }
                waitForExpectations(timeout: expectationTimeout)
            }
        }
    }
    
    private func createTasks() {
        let tasks = [TestData.runMarathonTask, TestData.buyTeaTask]
        
        tasks.forEach { [weak self] task in
            let createTaskExpectation = expectation(description: "wait for return")
            self?.storage.createTask(task) { result in
                createTaskExpectation.fulfill()
            }
            waitForExpectations(timeout: expectationTimeout)
        }
        
        self.tasks = tasks
    }
}

extension TaskStorageImplTests {
    struct TestData {
        static let listIdentifier = "List-ID"
        static let runMarathonTaskIdentifier = "ID-1"
        static let runMarathonTask = Task(
            identifier: runMarathonTaskIdentifier,
            name: "Run a marathon",
            status: .undone,
            creationDate: Date()
        )
        static let buyTeaTask = Task(
            identifier: "ID-2",
            name: "Buy a pu-erh tea",
            status: .done,
            creationDate: Date()
        )
        static let writeTestsTask = Task(
            identifier: runMarathonTaskIdentifier,
            name: "Write tests",
            status: .done,
            creationDate: Date()
        )
        static let makeCoffeeTask = Task(
            identifier: "ID",
            name: "Make a coffee",
            status: .done,
            creationDate: Date()
        )
    }
}
