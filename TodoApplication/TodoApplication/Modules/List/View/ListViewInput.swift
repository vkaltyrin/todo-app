import Foundation

protocol ListViewInput: AlertDisplayble, ActionSheetDisplayble, ActivityDisplayble {
    func showItems(_ viewModel: ListDataFlow.ShowLists.ViewModel)
    func showEditing(_ identifier: Identifier)
    func deleteItem(_ identifier: Identifier)
    func openTasks(_ identifier: Identifier)
}
