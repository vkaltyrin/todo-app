protocol TaskInteractor: class {
    func fetchItems()
    func deleteItem(request: TaskDataFlow.DeleteTask.Request)
    func updateItemName(request: TaskDataFlow.UpdateTaskName.Request)
    func updateItemDoneness(request: TaskDataFlow.UpdateTaskDoneness.Request)
    func createItem(request: TaskDataFlow.CreateTask.Request)
    func openTaskActions(request: TaskDataFlow.OpenTaskActions.Request)
    func openTaskEditing(request: TaskDataFlow.OpenTaskEditing.Request)
}
