@testable import TodoApplication
import XCTest

final class ListPresenterMock: ListPresenter {

    var invokedPresentItems = false
    var invokedPresentItemsCount = 0
    var invokedPresentItemsParameters: (response: ListDataFlow.ShowLists.Response, Void)?
    var invokedPresentItemsParametersList = [(response: ListDataFlow.ShowLists.Response, Void)]()

    func presentItems(_ response: ListDataFlow.ShowLists.Response) {
        invokedPresentItems = true
        invokedPresentItemsCount += 1
        invokedPresentItemsParameters = (response, ())
        invokedPresentItemsParametersList.append((response, ()))
    }
}