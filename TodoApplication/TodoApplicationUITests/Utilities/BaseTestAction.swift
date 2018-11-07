import Foundation

protocol TestActionable: class {
    func perform()
}

class BaseTestAction: TestActionable {
    
    let matcherFactory: MatcherFactory = MatcherFactoryImpl()
    
    func perform() {
        assertionFailure("not implemented")
    }
}
