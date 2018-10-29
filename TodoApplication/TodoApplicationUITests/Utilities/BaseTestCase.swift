import EarlGrey
@testable import TodoApplication
import XCTest

class BaseTestCase: XCTestCase {

    private let timeout = TimeInterval(15)

    override func setUp() {
        super.setUp()

        let testStorageUtility = TestStorageUtilityImpl()
        testStorageUtility.resetState()
    }

    func precondition(_ description: String, closure: () -> ()) {
        closure()
    }

    func step(_ description: String, closure: () -> ()) {
        closure()
    }

    func assert(_ message: String, assertationClosure: () -> (Bool)) {
        XCTAssert(assertationClosure())
    }

    func expect(_ message: String, closure: () -> ()) {
        closure()
    }

    func wait(_ message: String, accessibilityID: String) {
        let condition = GREYCondition(name: message) { () -> Bool in
            var error: NSError?
            EarlGrey.selectElement(with: grey_accessibilityID(accessibilityID))
                .assert(grey_sufficientlyVisible(), error: &error)

            return error == nil
        }
        condition.wait(withTimeout: timeout)
    }

}
