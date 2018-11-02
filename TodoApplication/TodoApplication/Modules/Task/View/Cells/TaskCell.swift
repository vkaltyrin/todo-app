import UIKit

class TaskCell: BaseCell {

    // MARK: - Private
    private var onSwitchTap: ((Bool) -> ())?

    // MARK: - IBOutlets

    @IBOutlet weak var switchView: UISwitch!

    // MARK: - IBActions

    @IBAction func onValueChanged(_ sender: UISwitch) {
        onSwitchTap?(sender.isOn)
    }
}

extension TaskCell: ConfigurableCell {
    typealias ViewModel = TaskViewModel

    func configure(_ viewModel: TaskViewModel) {
        self.onSwitchTap = viewModel.onSwitchTap
        textField.text = viewModel.name
        switchView.setOn(viewModel.isDone, animated: false)
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
