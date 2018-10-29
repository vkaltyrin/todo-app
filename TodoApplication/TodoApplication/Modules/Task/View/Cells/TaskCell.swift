import UIKit

class TaskCell: BaseCell {}

extension TaskCell: ConfigurableCell {
    typealias ViewModel = TaskViewModel

    func configure(_ viewModel: TaskViewModel) {
        textField.text = viewModel.name
    }
}

extension TaskCell: AccessibleCell {
    func setAccessibilityIdentifierIndex(index: Int) {
        textField.qaAccessibilityIdentifier = CellAccessibilityIdentifierBuilder.build(
            identifier: TaskDataFlow.AccessibilityIdentifiers.taskTextField,
            index: index
        )
    }
}
