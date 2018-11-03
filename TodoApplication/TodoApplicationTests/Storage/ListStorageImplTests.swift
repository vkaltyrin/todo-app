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
        let lists = TestData.allStrings.map { List(name: $0) }
        let expectedStrings = TestData.allStrings.sorted()
    
        // when
        let createListsExpectation = expectation(description: "wait for creating of lists")
        createLists(lists: lists) {
            createListsExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        let response = expectation(description: "wait for return")
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
            XCTFail("received lists count must be equal to expected lists count")
            return
        }
        let receivedStrings = receivedLists.map { $0.name }
        XCTAssertEqual(receivedStrings, expectedStrings)
    }
    
    func testFetchLists_returnEmptyResult_forEmptyLists() {
        // given
        var receivedLists: [List] = []
        
        // when
        let response = expectation(description: "wait for return")
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
        guard receivedLists.count == 0 else {
            XCTFail("received lists count must be equal to expected lists count")
            return
        }
    }
    
    func testDeleteList_deleteList_withSuccess() {
        // given
        let identifier = TestData.listIdentifier
        var receivedError: StorageError?
        
        // when
        let createListsExpectation = expectation(description: "wait for creating of lists")
        createLists(lists: TestData.lists) {
            createListsExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        let response = expectation(description: "wait for return")
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
        
        // when
        let createListsExpectation = expectation(description: "wait for creating of lists")
        createLists(lists: TestData.lists) {
            createListsExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        let response = expectation(description: "wait for return")
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
        
        // when
        let createListsExpectation = expectation(description: "wait for creating of lists")
        createLists(lists: TestData.lists) {
            createListsExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        let response = expectation(description: "wait for return")
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
        
        // when
        let createListsExpectation = expectation(description: "wait for creating of lists")
        createLists(lists: TestData.lists) {
            createListsExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        let response = expectation(description: "wait for return")
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
        
        // when
        let createListsExpectation = expectation(description: "wait for creating of lists")
        createLists(lists: TestData.lists) {
            createListsExpectation.fulfill()
        }
        waitForExpectations(timeout: expectationTimeout)
        
        let response = expectation(description: "wait for return")
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
    private func createLists(lists: [List], completion: @escaping () -> ()) {
        self.lists = lists
        let group = DispatchGroup()
        lists.forEach { [weak self] list in
            group.enter()
            self?.storage.createList(list) { result in
                group.leave()
            }
        }
        group.notify(queue: .main, execute: completion)
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
        
        static let lists = [todayList, tomorrowList]
        static let someTextArray =
            """
            Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code. In fact, you’ve been using generics throughout the Language Guide, even if you didn’t realize it. For example, Swift’s Array and Dictionary types are both generic collections. You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.
            """
                .components(separatedBy: " ")
        static let emptyStrings = Array(repeating: "", count: Int(arc4random() % 50))
        static let allStrings = (someTextArray + emptyStrings).shuffled()
    }
}
