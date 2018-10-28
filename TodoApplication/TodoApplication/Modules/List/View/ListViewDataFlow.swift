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

struct ListViewShowItemsData {

    struct Response {
        let result: ListResult
    }

    struct ViewModel {
        let state: ViewControllerState<ListViewModel>
    }
}
