import UIKit

extension UITableView {
    func registerNib(cellClass: AnyClass) {
        let nibName = String(describing: cellClass)
        register(
            UINib(nibName: nibName, bundle: nil),
            forCellReuseIdentifier: nibName
        )
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T? {
        let reuseId = String(describing: T.self)

        if let cell = dequeueReusableCell(withIdentifier: reuseId) as? T {
            return cell
        }

        return nil
    }
}
