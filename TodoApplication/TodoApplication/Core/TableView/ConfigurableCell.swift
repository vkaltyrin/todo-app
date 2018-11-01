import Foundation
import UIKit

protocol ConfigurableCell: CellFocusable {
    associatedtype ViewModel

    static var reuseIdentifier: String { get }

    func configure(_ viewModel: ViewModel)
}

extension ConfigurableCell where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
