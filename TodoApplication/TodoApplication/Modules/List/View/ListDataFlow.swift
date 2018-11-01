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
            let result: CreateListResult
        }

        enum CreateListResult {
            case success(identifier: Identifier, lists: [List])
            case failure(StorageError)
        }
    }

    struct OpenListActions {
        struct Request {
            let identifier: Identifier
            let name: String
        }

        struct ViewModel {
            let dialog: Dialog
        }
    }

    struct OpenListEditing {
        struct Request {
            let identifier: Identifier
        }
    }

    enum ViewControllerState {
        case loading
        case result(items: [TableSection], listIdentifier: Identifier?)
        case error(dialog: Dialog)
        case editing(listIdentifier: Identifier)
    }

    enum AccessibilityIdentifiers {
        static let createListButton = "createListButton"
        static let listTextField = "listTextField"
    }

}
// swiftlint:enable nesting
