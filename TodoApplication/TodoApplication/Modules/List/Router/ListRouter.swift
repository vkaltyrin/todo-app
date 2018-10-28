import Foundation

protocol ListRouter: class {
    func openTasks(listIdentifier: String)
}

final class ListRouterImpl: ListRouter {
    private unowned let transitionHandler: TransitionHandler

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func openTasks(listIdentifier: String) {

    }
}
