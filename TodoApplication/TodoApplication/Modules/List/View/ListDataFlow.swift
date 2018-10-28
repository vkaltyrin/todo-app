import Foundation

enum ViewControllerState<T> {
    case loading
    case result(items: [T])
    case empty(message: String)
    case error(message: String)
}

struct ListViewModel {
    let identifier: Identifier
    let title: String
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
            let result: GeneralResult
        }
        
        struct ViewModel {
            let state: ViewControllerState<ListViewModel>
        }
    }

    struct UpdateList {
        struct Request {
            let result: GeneralResult
        }
        
        struct ViewModel {
            let state: ViewControllerState<ListViewModel>
        }
    }
}
// swiftlint:enable nesting
