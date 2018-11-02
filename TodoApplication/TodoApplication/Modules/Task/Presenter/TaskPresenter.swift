protocol TaskPresenter: class {
    func presentShowTasks(_ response: TaskDataFlow.ShowTasks.Response, identifier: Identifier?)
    func presentError(_ error: StorageError)
    func presentTaskActions(_ identifier: Identifier)
    func presentTaskEditing(_ identifier: Identifier)
    func presentLoading()
}
