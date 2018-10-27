@testable import TodoApplication
import XCTest

class TaskStorageImplTests: XCTestCase {
    
    // MARK: - Subject under test
    var storage: TaskStorage!
    
    // MARK: - Set Up
    
    override func setUp() {
        super.setUp()
        resetStorageState()
    }
    
    func resetStorageState() {
        storage = TaskStorageImpl()
    }
    
    // MARK: - Tear Down
    
    override func tearDown() {
        super.tearDown()
        storage = nil
    }
    
    // MARK: - Tests
    
    func testFetchTasks_returnTasks_withSuccess() {
        // Given
        let identifier = "identifier"
        let expectedTasks = [
            Task(identifier: "id", name: "Task1", status: .done, creationDate: Date()),
            Task(identifier: "id2", name: "Task2", status: .undone, creationDate: Date())
            ]
        let response = expectation(description: "wait for return")
        var receivedError: Error?
        var receivedTasks: [Task] = []
        
        // When
        storage.fetchTasks(listId: identifier) { result in
            result.onSuccess { tasks in
                receivedTasks = tasks
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0)
        
        // Then
        XCTAssertEqual(receivedTasks, expectedTasks)
        XCTAssertNil(receivedError)
    }
    
    func testDeleteTask_deleteTask_withSuccess() {
        // Given
        let identifier = "identifier"
        let response = expectation(description: "wait for return")
        var receivedError: Error?
        
        // When
        storage.deleteTask(taskId: identifier) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0)
        
        // Then
        XCTAssertNil(receivedError)
    }
    
    func testCreateTask_createTask_withSuccess() {
        // Given
        let task = Task(identifier: "indentifier", name: "name", status: .done, creationDate: Date())
        let response = expectation(description: "wait for return")
        var receivedError: Error?
        
        // When
        storage.createTask(task) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0)
        
        // Then
        XCTAssertNil(receivedError)
    }
    
    func testUpdateTask_updateTask_withSuccess() {
        // Given
        let task = Task(identifier: "indentifier", name: "name", status: .done, creationDate: Date())
        let response = expectation(description: "wait for return")
        var receivedError: Error?
        
        // When
        storage.updateTask(task) { result in
            result.onSuccess {
                response.fulfill()
            }
            result.onFailure { error in
                receivedError = error
                response.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0)
        
        // Then
        XCTAssertNil(receivedError)
    }
    
}

extension Task: Equatable {}

public func ==(lhs: Task, rhs: Task) -> Bool {
    return lhs.identifier == rhs.identifier
        && lhs.name == rhs.name
        && lhs.status == rhs.status
        && lhs.creationDate == rhs.creationDate
}
