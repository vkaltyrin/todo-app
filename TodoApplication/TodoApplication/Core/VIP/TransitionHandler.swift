import UIKit

protocol TransitionHandler: class {
    func openModule(_ module: UIViewController)
}

extension UIViewController: TransitionHandler {
    func openModule(_ module: UIViewController) {
        navigationController?.pushViewController(module, animated: true)
    }
}
