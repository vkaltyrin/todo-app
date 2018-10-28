import Foundation
import UIKit

final class ListViewController: UIViewController {
    let interactor: ListInteractor
    let router: ListRouter

    init(interactor: ListInteractor, router: ListRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListViewController: ListView {

}
