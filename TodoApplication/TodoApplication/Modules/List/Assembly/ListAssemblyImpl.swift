import Foundation
import UIKit

final class ListAssemblyImpl: ListAssembly {

    func module() -> ListViewController {

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
        viewController.tableManager = TableManagerImpl()

        return viewController
    }

}
