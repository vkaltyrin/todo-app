@testable import TodoApplication
import XCTest

final class TaskAssemblyTests: TestCase {
    // MARK: - Subject Under Test
    var assembly: TaskAssembly!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        assembly = TaskAssemblyImpl()
    }
    
    // MARK: - Tests
    func testModule_setUpDependeciesCorrectly() {
        // when
        let module = assembly.module(
            listIdentifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        
        // then
        XCTAssertNotNil(module.interactor)
        XCTAssertNotNil(module.tableDirector)
    }
}
