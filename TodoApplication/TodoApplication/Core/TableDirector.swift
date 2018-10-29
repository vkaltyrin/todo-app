import Foundation
import UIKit

protocol TableDirector: class, UITableViewDelegate, UITableViewDataSource {
    func setup(with tableView: UITableView)

    func reload()
}
