@testable import TodoApplication
import XCTest

final class ListExtensionsTests: TestCase {
    // MARK: - Tests
    func testList_isMappedCorrectlyInRealmList_forNotNilIdentifier() {
        // given
        let list = List(
            name: Identifier.generateUniqueIdentifier(),
            tasks: TestData.tasks,
            identifier: Identifier.generateUniqueIdentifier()
        )
        
        // when
        let realmList = list.toRealm()
        
        // then
        XCTAssertEqual(realmList.name, list.name)
        XCTAssertEqual(realmList.tasks.map { $0.toTask() }, list.tasks)
        XCTAssertEqual(realmList.identifier, list.identifier)
    }
    
    func testList_isMappedCorrectlyInRealmList_forNilIdentifier() {
        // given
        let list = List(
            name: Identifier.generateUniqueIdentifier(),
            tasks: TestData.tasks
        )
        
        // when
        let realmList = list.toRealm()
        
        // then
        XCTAssertEqual(realmList.name, list.name)
        XCTAssertEqual(realmList.tasks.map { $0.toTask() }, list.tasks)
        XCTAssertNotNil(realmList.identifier)
    }
    
    func testList_isMappedCorrectlyInRealmList_forEmptyTasks() {
        // given
        let list = List(
            name: Identifier.generateUniqueIdentifier(),
            tasks: [],
            identifier: Identifier.generateUniqueIdentifier()
        )
        
        // when
        let realmList = list.toRealm()
        
        // then
        XCTAssertEqual(realmList.name, list.name)
        XCTAssertEqual(realmList.identifier, list.identifier)
        XCTAssertEqual(realmList.tasks.count, 0)
    }
}

extension ListExtensionsTests {
    struct TestData {
        static let tasks = Array(
            repeating: Task(
                name: Identifier.generateUniqueIdentifier(),
                identifier: Identifier.generateUniqueIdentifier()
            ),
            count: Int(arc4random() % 100)
        )
    }
}
