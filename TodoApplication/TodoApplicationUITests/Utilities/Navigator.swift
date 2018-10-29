import Foundation
@testable import TodoApplication
import UIKit

enum Screen {
    case lists
    case tasks
}

protocol Navigator: class {
    func openScreen(_ screen: Screen)
}

final class NavigatorImpl: Navigator {

    // MARK: - Navigator

    func openScreen(_ screen: Screen) {
        switch screen {
        case .lists:
            displayViewController(ListAssemblyImpl().module())
        case .tasks:
            break
        }
    }

    // MARK: - Private

    private func displayViewController(_ viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = UINavigationController(
            rootViewController: viewController
        )
    }

}
