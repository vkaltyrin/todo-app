import Foundation
import UIKit

final class TaskAssemblyImpl: TaskAssembly {

    func module(listIdentifier: Identifier, name: String) -> TaskViewController {

        let viewController = TaskViewController()
        viewController.title = name

        let presenter = TaskPresenterImpl(
            view: viewController
        )

        let interactor = TaskInteractorImpl(
            listIdentifier: listIdentifier,
            presenter: presenter,
            taskStorage: TaskStorageImpl()
        )

        viewController.interactor = interactor
        viewController.tableManager = TableManagerImpl()

        return viewController
    }

}
