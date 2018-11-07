import Foundation
@testable import TodoApplication
import UIKit

enum Screen {
    case lists
    case tasks
}

protocol Navigator: class {
    func openScreen(_ screen: Screen)
    func dismissAll()
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
    
    func dismissAll() {
        rootViewController?.dismiss(animated: false, completion: nil)
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }

    // MARK: - Private

    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    private var rootViewController: UIViewController? {
        get {
            return appDelegate?.window?.rootViewController
        }
        set {
            appDelegate?.window?.rootViewController = rootViewController
        }
    }
    
    private func displayViewController(_ viewController: UIViewController) {
        rootViewController = viewController
    }

}
