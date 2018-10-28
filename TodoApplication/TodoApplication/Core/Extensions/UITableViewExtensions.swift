import UIKit

extension UITableView {
    func registerNib(cellClass: AnyClass) {
        let nibName = String(describing: cellClass)
        register(
            UINib(nibName: nibName, bundle: nil),
            forCellReuseIdentifier: nibName
        )
    }
}
