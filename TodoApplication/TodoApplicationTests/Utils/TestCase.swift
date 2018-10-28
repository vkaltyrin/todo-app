import XCTest

class TestCase: XCTestCase {
    let expectationTimeout = TimeInterval(0.5)
}

class StorageTestCase: TestCase {
    // MARK: - Test storage to reset state after each test
    var testStorageUtility: TestStorageUtility = TestStorageUtilityImpl()
    
    override func setUp() {
        super.setUp()
        
        testStorageUtility.resetState()
    }
}
