@testable import TodoApplication
import XCTest

final class TaskExtensionsTests: TestCase {
    // MARK: - Tests
    func testTask_isMappedCorrectlyInRealmTask_forNotNilIdentifier() {
        // given
        let task = Task(
            name: Identifier.generateUniqueIdentifier(),
            isDone: true,
            identifier: Identifier.generateUniqueIdentifier(),
            creationDate: Date()
        )
        
        // when
        let realmTask = task.toRealm()
        
        // then
        XCTAssertEqual(task.name, realmTask.name)
        XCTAssertEqual(task.isDone, realmTask.isDone)
        XCTAssertEqual(task.identifier, realmTask.identifier)
        XCTAssertEqual(task.creationDate, realmTask.creationDate)
    }
    
    func testTask_isMappedCorrectlyInRealmTask_forNilIdentifier() {
        // given
        let task = Task(
            name: Identifier.generateUniqueIdentifier(),
            isDone: true,
            creationDate: Date()
        )
        
        // when
        let realmTask = task.toRealm()
        
        // then
        XCTAssertEqual(task.name, realmTask.name)
        XCTAssertEqual(task.isDone, realmTask.isDone)
        XCTAssertEqual(task.creationDate, realmTask.creationDate)
        XCTAssertNotNil(realmTask.identifier)
    }
    
    func testTaskArray_isMappedCorrectlyInRealmTaskArray() {
        // given
        let tasks = Array.init(
            repeating: Task(
                name: Identifier.generateUniqueIdentifier(),
                isDone: true,
                identifier: Identifier.generateUniqueIdentifier(),creationDate: Date()
            ),
            count: Int(arc4random() % 100)
        )
        
        // when
        let realmTasks = tasks.toRealm()
        
        // then
        realmTasks.enumerated().forEach { offset, realmTask in
            XCTAssertEqual(tasks[safe: offset]?.name, realmTask.name)
            XCTAssertEqual(tasks[safe: offset]?.isDone, realmTask.isDone)
            XCTAssertEqual(tasks[safe: offset]?.identifier, realmTask.identifier)
            XCTAssertEqual(tasks[safe: offset]?.creationDate, realmTask.creationDate)
        }
    }
}
