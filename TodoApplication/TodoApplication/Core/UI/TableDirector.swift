import Foundation
import UIKit

protocol TableDirector: class {
    func focusOnCell(_ identifier: Identifier)
    func setup(with tableView: UITableView)
    var onDeleteTap: ((_ identifier: Identifier) -> ())? { get set }
}
