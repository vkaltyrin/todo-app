import Foundation

protocol ListRouter: class {
    func openTasks()
}

final class ListRouterImpl: ListRouter {
    weak var transitionHandler: TransitionHandler?

    func openTasks() {

    }
}
