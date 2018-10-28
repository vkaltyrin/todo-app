import Foundation

enum ViewControllerState<T> {
    case loading
    case result(items: [T])
    case error(message: String)
}

enum ListViewError {

}

struct ListViewModel {
    let identifier: Identifier
    let name: String

}

// swiftlint:disable nesting
struct ListDataFlow {

    // Use cases
    struct ShowLists {
        struct Response {
            let result: ListResult
        }

        struct ViewModel {
            let state: ViewControllerState<ListViewModel>
        }
    }

    struct DeleteList {
        struct Request {
            let identifier: Identifier
        }

        struct Response {
            let result: GeneralResult
        }
    }

    struct UpdateList {
        struct Request {
            let identifier: Identifier
            let name: String
        }

        struct Response {
            let result: GeneralResult
        }
    }

    struct CreateList {
        struct Request {
            let name: String
        }

        struct Response {
            let result: StorageResult<List>
        }
    }

}
// swiftlint:enable nesting
