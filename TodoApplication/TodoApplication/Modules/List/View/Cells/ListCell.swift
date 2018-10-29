import UIKit

class ListCell: BaseCell {}

extension ListCell: ConfigurableCell {
    func configure(_ viewModel: ListViewModel) {
        textField.text = viewModel.name
    }
}
