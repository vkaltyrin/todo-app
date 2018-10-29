import Foundation

protocol ListRouter: class {
    func openTasks(listIdentifier: String, name: String)
}

final class ListRouterImpl: ListRouter {
    private unowned let transitionHandler: TransitionHandler

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func openTasks(listIdentifier: String, name: String) {
        let assembly = TaskAssemblyImpl()
        let module = assembly.module(listIdentifier: listIdentifier, name: name)
        transitionHandler.openModule(module)
    }
}
