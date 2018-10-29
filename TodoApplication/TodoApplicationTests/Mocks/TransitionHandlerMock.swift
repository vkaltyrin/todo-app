@testable import TodoApplication
import XCTest

final class TransitionHandlerMock: TransitionHandler {

    var invokedOpenModule = false
    var invokedOpenModuleCount = 0
    var invokedOpenModuleParameters: (module: UIViewController, Void)?
    var invokedOpenModuleParametersList = [(module: UIViewController, Void)]()

    func openModule(_ module: UIViewController) {
        invokedOpenModule = true
        invokedOpenModuleCount += 1
        invokedOpenModuleParameters = (module, ())
        invokedOpenModuleParametersList.append((module, ()))
    }
}
