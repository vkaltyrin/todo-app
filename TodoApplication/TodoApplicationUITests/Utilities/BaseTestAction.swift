import Foundation

protocol TestActionable: class {
    func perform()
}

class BaseTestAction: TestActionable {
    func perform() {
        assertionFailure("not implemented")
    }
}
