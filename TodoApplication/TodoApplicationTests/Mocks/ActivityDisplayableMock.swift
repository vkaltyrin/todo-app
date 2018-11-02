@testable import TodoApplication
import XCTest

final class ActivityDisplayableMock: ActivityDisplayable {

    var invokedStartActivity = false
    var invokedStartActivityCount = 0

    func startActivity() {
        invokedStartActivity = true
        invokedStartActivityCount += 1
    }

    var invokedStopActivity = false
    var invokedStopActivityCount = 0

    func stopActivity() {
        invokedStopActivity = true
        invokedStopActivityCount += 1
    }
}