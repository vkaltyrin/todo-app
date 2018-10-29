@testable import TodoApplication
import XCTest

final class ListPresenterTests: TestCase {
    // MARK: - Subject Under Test
    var presenter: ListPresenter!
    var viewMock: ListViewInputMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        viewMock = ListViewInputMock()
        presenter = ListPresenterImpl(view: viewMock)
    }
    
    // MARK: - Tests
    
    func testPresentShowLists_showLists_whenResultIsSuccessful() {
        // given
        let result = ListResult.success([])
        let response = ListDataFlow.ShowLists.Response(result: result)
        // when
        presenter.presentShowLists(response, identifier: nil)
        // then
        XCTAssertEqual(viewMock.invokedShowItemsCount, 1)
        XCTAssertNotNil(viewMock.invokedShowItemsParameters?.viewModel)
        
        guard let state = viewMock.invokedShowItemsParameters?.viewModel.state else {
            XCTFail()
            return
        }
        switch state {
        case .result:
            break
        default:
            XCTFail("Incorrect state")
        }
    }
    
    func testPresentShowLists_showError_whenResultIsFailed() {
        // given
        let error = StorageError.internalError
        let result = ListResult.failure(error)
        let response = ListDataFlow.ShowLists.Response(result: result)
        // when
        presenter.presentShowLists(response, identifier: nil)
        // then
        guard let state = viewMock.invokedShowItemsParameters?.viewModel.state else {
            XCTFail()
            return
        }
        switch state {
        case .error:
            break
        default:
            XCTFail("Incorrect state")
        }
    }
    
    func testPresentError_showError() {
        // given
        let error = StorageError.internalError
        // when
        presenter.presentError(error)
        // then
        guard let state = viewMock.invokedShowItemsParameters?.viewModel.state else {
            XCTFail()
            return
        }
        switch state {
        case .error:
            break
        default:
            XCTFail("Incorrect state")
        }
    }
    
    func testPresentListEditing_showEditing() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentListEditing(identifier)
        // then
        XCTAssertEqual(viewMock.invokedShowEditingCount, 1)
        XCTAssertNotNil(viewMock.invokedShowEditingParameters)
    }
    
    func testPresentListActions_showActionSheet() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentListActions(identifier)
        // then
        XCTAssertEqual(viewMock.invokedShowActionSheetCount, 1)
        XCTAssertNotNil(viewMock.invokedShowActionSheetParameters)
        XCTAssertEqual(viewMock.invokedShowActionSheetParameters?.dialog.actions.count, 4)
    }
    
    func testPresentListActions_showEditing_whenEditingActionIsTapped() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentListActions(identifier)
        let action = viewMock.invokedShowActionSheetParameters?.dialog.actions[safe: 0]
        action?.onTap?()
        // then
        XCTAssertEqual(viewMock.invokedShowEditingCount, 1)
    }
    
    func testPresentListActions_deleteItem_whenDeleteActionIsTapped() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentListActions(identifier)
        let action = viewMock.invokedShowActionSheetParameters?.dialog.actions[safe: 1]
        action?.onTap?()
        // then
        XCTAssertEqual(viewMock.invokedDeleteItemCount, 1)
    }
    
    func testPresentListActions_openTasks_whenOpenTasksActionIsTapped() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentListActions(identifier)
        let action = viewMock.invokedShowActionSheetParameters?.dialog.actions[safe: 2]
        action?.onTap?()
        // then
        XCTAssertEqual(viewMock.invokedOpenTasksCount, 1)
    }
    
}
