import Foundation

// swiftlint:disable nesting
struct ListDataFlow {

    // Use cases
    struct ShowLists {
        struct Response {
            let result: ListResult
        }

        struct ViewModel {
            let state: ViewControllerState
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

    struct OpenListActions {
        struct Request {
            let identifier: Identifier
        }

        struct ViewModel {
            let dialog: Dialog
        }
    }

    enum ViewControllerState {
        case loading
        case result(items: [ListViewModel])
        case error(dialog: Dialog)
        case editing(listIdentifier: Identifier)
        //case create(listIdentifier: Identifier, items: [ListViewModel])
    }

}
// swiftlint:enable nesting
