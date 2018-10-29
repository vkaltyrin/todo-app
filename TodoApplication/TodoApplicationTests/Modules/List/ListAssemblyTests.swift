@testable import TodoApplication
import XCTest

final class ListAssemblyTests: TestCase {
    // MARK: - Subject Under Test
    var assembly: ListAssembly!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        assembly = ListAssemblyImpl()
    }
    
    // MARK: - Tests
    func testModule_setUpDependeciesCorrectly() {
        // when
        let module = assembly.module()
        
        // then
        XCTAssertNotNil(module.interactor)
        XCTAssertNotNil(module.router)
        XCTAssertNotNil(module.tableDirector)
    }
}
