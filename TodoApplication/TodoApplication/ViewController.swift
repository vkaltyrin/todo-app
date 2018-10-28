import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let assembly = ListAssemblyImpl()
        let viewController = assembly.module()

        self.navigationController?.pushViewController(
            viewController,
            animated: false
        )
    }

}
