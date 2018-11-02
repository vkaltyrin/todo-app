import Foundation

// swiftlint:disable nesting
struct TaskDataFlow {

    // Use cases
    struct ShowTasks {
        struct Response {
            let result: TaskResult
        }

        struct ViewModel {
            let state: ViewState
        }
    }

    struct DeleteTask {
        struct Request {
            let identifier: Identifier
        }

        struct Response {
            let result: GeneralResult
        }
    }

    struct UpdateTask {
        struct Request {
            let identifier: Identifier
            let name: String
        }

        struct Response {
            let result: GeneralResult
        }
    }

    struct CreateTask {
        struct Request {
            let name: String
        }

        struct Response {
            let result: CreateTaskResult
        }

        enum CreateTaskResult {
            case success(identifier: Identifier, tasks: [Task])
            case failure(StorageError)
        }
    }

    struct OpenTaskActions {
        struct Request {
            let identifier: Identifier
        }

        struct ViewModel {
            let dialog: Dialog
        }
    }

    struct OpenTaskEditing {
        struct Request {
            let identifier: Identifier
        }
    }

    enum ViewState {
        case loading
        case result(items: [TableSection], identifier: Identifier?)
        case error(dialog: Dialog)
        case editing(identifier: Identifier)
    }

    enum AccessibilityIdentifiers {
        static let createTaskButton = "createTaskButton"
        static let taskTextField = "taskTextField"
    }

}
// swiftlint:enable nesting
