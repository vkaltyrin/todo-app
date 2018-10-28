@testable import TodoApplication
import XCTest

final class ListInteractorTests: TestCase {
    // MARK: - Subject Under Test
    var interactor: ListInteractor!
    var presenterMock: ListPresenterMock!
    var listStorageMock: ListStorageMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        presenterMock = ListPresenterMock()
        listStorageMock = ListStorageMock()
        interactor = ListInteractorImpl(
            presenter: presenterMock,
            listStorage: listStorageMock
        )
    }
    
    // MARK: - Tests

}