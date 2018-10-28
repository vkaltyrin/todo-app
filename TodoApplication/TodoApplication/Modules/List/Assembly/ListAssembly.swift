import Foundation
import UIKit

protocol Assembly: class {
    func module() -> UIViewController
}

final class ListAssemblyImpl: Assembly {

    func module() -> UIViewController {

        let viewController = ListViewController()

        let presenter = ListPresenterImpl(
            view: viewController
        )

        let interactor = ListInteractorImpl(
            presenter: presenter,
            listStorage: ListStorageImpl()
        )

        let router = ListRouterImpl(
            transitionHandler: viewController
        )

        viewController.router = router
        viewController.interactor = interactor

        return viewController
    }
}
