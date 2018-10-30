import Foundation

protocol TaskViewInput: AlertDisplayable, ActionSheetDisplayable, ActivityDisplayable {
    func showItems(_ viewModel: TaskDataFlow.ShowTasks.ViewModel)
    func showEditing(_ identifier: Identifier)
    func deleteItem(_ identifier: Identifier)
}
