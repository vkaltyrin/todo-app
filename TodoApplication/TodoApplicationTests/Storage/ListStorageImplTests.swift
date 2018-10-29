@testable import TodoApplication
import XCTest

final class ListStorageImplTests: StorageTestCase {
    
    // MARK: - Subject under test
    var storage: ListStorage!
    
    // MARK: - State
    var lists: [List] = []
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        storage = ListStorageImpl()
        createLists()
    }
    
    // MARK: - Tear Down
    override func tearDown() {
        super.tearDown()
        storage = nil
    }
    
    // MARK: - Tests
    func testFetchLists_returnList_sortedAscendingByName() {
        // given
        var receivedLists: [List] = []
        let response = expectation(description: "wait for return")
        
        // when
        storage.fetchLists() { result in
            result.onSuccess { lists in
                receivedLists = lists
                response.fulfill()
            }
            result.onFailure { error in
                XCTFail("fetchLists should not return a error \(error)")
            }
        }
        waitForExpectations(timeout: expectationTimeout)
        
        // then
        guard receivedLists.count == lists.count else {
            XCTFail("fetchLists should return tasks")
            return
        }
//        XCTAssertEqual(receivedLists[0], TestData.buyTeaTask)
//        XCTAssertEqual(receivedLists[1], TestData.runMarathonTask)
    }
    
    func testDeleteList_deleteList_withSuccess() {
        // given
        let identifier = TestData.listIdentifier
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.deleteList(listId: identifier) { result in
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
    
    func testDeleteList_returnError_withWrongListIdentifier() {
        // given
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.deleteList(listId: TestData.wrongIdentifier) { result in
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
    
    func testCreateList_createList_withSuccess() {
        // given
        let list = TestData.todayList
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.createList(list) { result in
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
    
    func testUpdateList_updateList_withSuccess() {
        // given
        let list = TestData.newTodayList
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateList(listId: list.identifier ?? "", name: list.name) { result in
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
    
    func testUpdateList_returnError_withWrongListIdentifier() {
        // given
        let list = TestData.notExistingList
        var receivedError: StorageError?
        let response = expectation(description: "wait for return")
        
        // when
        storage.updateList(listId: list.identifier ?? "", name: list.name) { result in
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
    private func createLists() {
        let lists = [TestData.todayList, TestData.tomorrowList]
        
        lists.forEach { [weak self] list in
            let createTaskExpectation = expectation(description: "wait for return")
            self?.storage.createList(list) { result in
                createTaskExpectation.fulfill()
            }
            waitForExpectations(timeout: expectationTimeout)
        }
        
        self.lists = lists
    }
}

extension ListStorageImplTests {
    struct TestData {
        static let listIdentifier = Identifier.generateUniqueIdentifier()
        static let wrongIdentifier = Identifier.generateUniqueIdentifier()
        static let tasks = [
            TaskStorageImplTests.TestData.buyTeaTask,
            TaskStorageImplTests.TestData.runMarathonTask
        ]
        
        static let todayList = List(
            name: "Today List",
            tasks: tasks,
            identifier: listIdentifier
        )
        
        static let tomorrowList = List(
            name: "Tomorrow List",
            tasks: tasks,
            identifier: Identifier.generateUniqueIdentifier()
        )
        
        static let newTodayList = List(
            name: "New Today List",
            tasks: [TaskStorageImplTests.TestData.makeCoffeeTask],
            identifier: listIdentifier
        )
        
        static let notExistingList = List(
            name: "",
            tasks: [],
            identifier: Identifier.generateUniqueIdentifier()
        )
    }
}
