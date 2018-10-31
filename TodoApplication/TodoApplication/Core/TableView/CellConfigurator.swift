import Foundation
import UIKit

protocol CellConfigurator: CellActionable {
    func configure(_ cell: UITableViewCell)

    var reuseIdentifier: String { get }
    var cellType: AnyClass { get }
}
