import Foundation

protocol ListViewInput: AlertDisplayable, ActionSheetDisplayable, ActivityDisplayable {
    func showEditing(_ identifier: Identifier)
    func deleteItem(_ identifier: Identifier)
    func openTasks(_ identifier: Identifier, name: String)
    func selectItem(_ identifier: Identifier, name: String)
    func updateItem(_ identifier: Identifier, name: String)
    func createItem(name: String)
    func fetchItems()
    func reloadTable(_ sections: [TableSection])
    func focusOn(_ identifier: Identifier)
    func setOnAddTap(_ onAddTap: (() -> ())?)
}
