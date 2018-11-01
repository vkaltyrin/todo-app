import Foundation

protocol ListPresenter: class {
    func presentShowLists(_ response: ListDataFlow.ShowLists.Response, identifier: Identifier?)
    func presentError(_ error: StorageError)
    func presentListActions(_ identifier: Identifier, name: String)
    func presentListEditing(_ identifier: Identifier)
    func presentLoading()
}
