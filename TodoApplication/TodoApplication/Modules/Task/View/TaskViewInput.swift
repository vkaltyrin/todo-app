import Foundation

protocol TaskViewInput: AlertDisplayble, ActionSheetDisplayble, ActivityDisplayble {
    func showItems(_ viewModel: TaskDataFlow.ShowTasks.ViewModel)
    func showEditing(_ identifier: Identifier)
    func deleteItem(_ identifier: Identifier)
}
