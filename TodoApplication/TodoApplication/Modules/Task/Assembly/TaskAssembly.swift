import Foundation
import UIKit

protocol TaskAssembly: class {
    func module(listIdentifier: Identifier, name: String) -> TaskViewController
}

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
        viewController.tableDirector = TaskViewTableDirectorImpl()

        return viewController
    }

}
