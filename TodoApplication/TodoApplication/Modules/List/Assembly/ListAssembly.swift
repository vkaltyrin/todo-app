import Foundation
import UIKit

protocol Assembly: class {
    func module() -> UIViewController
}

final class ListAssemblyImpl: Assembly {

    func module() -> UIViewController {

        let presenter = ListPresenterImpl()

        let interactor = ListInteractorImpl(
            presenter: presenter,
            listStorage: ListStorageImpl()
        )
        let router = ListRouterImpl()

        let viewController = ListViewController(
            interactor: interactor,
            router: router
        )

        presenter.view = viewController
        router.transitionHandler = viewController

        return viewController
    }
}
