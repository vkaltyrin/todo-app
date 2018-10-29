@testable import TodoApplication
import XCTest

final class ListRouterTests: TestCase {
    // MARK: - Subject Under Test
    var router: ListRouter!
    var transitionHandlerMock: TransitionHandlerMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        transitionHandlerMock = TransitionHandlerMock()
        router = ListRouterImpl(
            transitionHandler: transitionHandlerMock
        )
    }
    
    // MARK: - Tests
    func testRouter_openModule() {
        // when
        router.openTasks(
            listIdentifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // then
        XCTAssertEqual(transitionHandlerMock.invokedOpenModuleCount, 1)
    }
}
