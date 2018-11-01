@testable import TodoApplication
import XCTest

final class ListPresenterMock: ListPresenter {

    var invokedPresentShowLists = false
    var invokedPresentShowListsCount = 0
    var invokedPresentShowListsParameters: (response: ListDataFlow.ShowLists.Response, identifier: Identifier?)?
    var invokedPresentShowListsParametersList = [(response: ListDataFlow.ShowLists.Response, identifier: Identifier?)]()

    func presentShowLists(_ response: ListDataFlow.ShowLists.Response, identifier: Identifier?) {
        invokedPresentShowLists = true
        invokedPresentShowListsCount += 1
        invokedPresentShowListsParameters = (response, identifier)
        invokedPresentShowListsParametersList.append((response, identifier))
    }

    var invokedPresentError = false
    var invokedPresentErrorCount = 0
    var invokedPresentErrorParameters: (error: StorageError, Void)?
    var invokedPresentErrorParametersList = [(error: StorageError, Void)]()

    func presentError(_ error: StorageError) {
        invokedPresentError = true
        invokedPresentErrorCount += 1
        invokedPresentErrorParameters = (error, ())
        invokedPresentErrorParametersList.append((error, ()))
    }

    var invokedPresentListActions = false
    var invokedPresentListActionsCount = 0
    var invokedPresentListActionsParameters: (identifier: Identifier, name: String)?
    var invokedPresentListActionsParametersList = [(identifier: Identifier, name: String)]()

    func presentListActions(_ identifier: Identifier, name: String) {
        invokedPresentListActions = true
        invokedPresentListActionsCount += 1
        invokedPresentListActionsParameters = (identifier, name)
        invokedPresentListActionsParametersList.append((identifier, name))
    }

    var invokedPresentListEditing = false
    var invokedPresentListEditingCount = 0
    var invokedPresentListEditingParameters: (identifier: Identifier, Void)?
    var invokedPresentListEditingParametersList = [(identifier: Identifier, Void)]()

    func presentListEditing(_ identifier: Identifier) {
        invokedPresentListEditing = true
        invokedPresentListEditingCount += 1
        invokedPresentListEditingParameters = (identifier, ())
        invokedPresentListEditingParametersList.append((identifier, ()))
    }

    var invokedPresentLoading = false
    var invokedPresentLoadingCount = 0

    func presentLoading() {
        invokedPresentLoading = true
        invokedPresentLoadingCount += 1
    }
}
