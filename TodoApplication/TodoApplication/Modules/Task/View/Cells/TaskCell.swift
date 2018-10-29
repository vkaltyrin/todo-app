import UIKit

class TaskCell: BaseCell {}

extension TaskCell: ConfigurableCell {
    typealias ViewModel = TaskViewModel

    func configure(_ viewModel: TaskViewModel) {
        textField.text = viewModel.name
    }
}
