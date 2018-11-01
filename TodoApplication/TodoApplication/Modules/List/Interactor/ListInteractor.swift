protocol ListInteractor: class {
    func fetchItems()
    func deleteItem(request: ListDataFlow.DeleteList.Request)
    func updateItem(request: ListDataFlow.UpdateList.Request)
    func createItem(request: ListDataFlow.CreateList.Request)
    func openListActions(request: ListDataFlow.OpenListActions.Request)
    func openListEditing(request: ListDataFlow.OpenListEditing.Request)
}
