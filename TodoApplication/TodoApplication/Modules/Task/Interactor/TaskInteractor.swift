import Foundation

protocol TaskInteractor: class {
    func fetchItems()
    func deleteItem(request: TaskDataFlow.DeleteTask.Request)
    func updateItem(request: TaskDataFlow.UpdateTask.Request)
    func createItem(request: TaskDataFlow.CreateTask.Request)
    func openTaskActions(request: TaskDataFlow.OpenTaskActions.Request)
    func openTaskEditing(request: TaskDataFlow.OpenTaskEditing.Request)
}

final class TaskInteractorImpl: TaskInteractor {
    // MARK: - Dependencies
    private let presenter: TaskPresenter
    private let taskStorage: TaskStorage

    // MARK: - State
    private let listIdentifier: Identifier

    // MARK: - Init
    init(listIdentifier: Identifier,
         presenter: TaskPresenter,
         taskStorage: TaskStorage) {
        self.listIdentifier = listIdentifier
        self.presenter = presenter
        self.taskStorage = taskStorage
    }

    // MARK: - TaskInteractor
    func fetchItems() {
        fetchItemsResponse { [weak self] response in
            self?.presenter.presentShowTasks(response, identifier: nil)
        }
    }

    func deleteItem(request: TaskDataFlow.DeleteTask.Request) {
        taskStorage.deleteTask(taskId: request.identifier) { [weak self] result in
            let response = TaskDataFlow.DeleteTask.Response(result: result)
            switch response.result {
            case .success:
                self?.fetchItems()
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func updateItem(request: TaskDataFlow.UpdateTask.Request) {
        taskStorage.updateTask(taskId: request.identifier, name: request.name) { [weak self] result in
            let response = TaskDataFlow.UpdateTask.Response(result: result)
            switch response.result {
            case .success:
                self?.fetchItems()
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func createItem(request: TaskDataFlow.CreateTask.Request) {
        let task = Task(name: request.name)
        taskStorage.createTask(listId: listIdentifier, task: task) { [weak self] result in
            switch result {
            case .success(let createdTaskIdentifier):
                self?.fetchAndShowItems(identifier: createdTaskIdentifier)
            case .failure(let error):
                self?.presenter.presentError(error)
            }
        }
    }

    func openTaskActions(request: TaskDataFlow.OpenTaskActions.Request) {
        presenter.presentTaskActions(request.identifier)
    }

    func openTaskEditing(request: TaskDataFlow.OpenTaskEditing.Request) {
        presenter.presentTaskEditing(request.identifier)
    }

    // MARK: - Private

    private func fetchAndShowItems(identifier: Identifier) {
        taskStorage.fetchTasks(listId: listIdentifier) { [weak self] _ in
            self?.fetchItemsResponse { response in
                self?.presenter.presentShowTasks(
                    response,
                    identifier: identifier
                )
            }
        }
    }

    private func fetchItemsResponse(completion: @escaping (TaskDataFlow.ShowTasks.Response) -> ()) {
        taskStorage.fetchTasks(listId: listIdentifier) { result in
            let response = TaskDataFlow.ShowTasks.Response(result: result)
            completion(response)
        }
    }
}
