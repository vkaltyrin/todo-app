@testable import TodoApplication
import XCTest

final class TaskPresenterTests: TestCase {
    // MARK: - Subject Under Test
    var presenter: TaskPresenter!
    var viewMock: TaskViewInputMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        viewMock = TaskViewInputMock()
        presenter = TaskPresenterImpl(view: viewMock)
    }
    
    // MARK: - Tests
    
    func testPresentShowTasks_showTasks_whenResultIsSuccessful() {
        // given
        let result = TaskResult.success([Task(name: "Sleep"), Task(name: "Buy gift for a friend")])
        let response = TaskDataFlow.ShowTasks.Response(result: result)
        // when
        presenter.presentShowTasks(response, identifier: nil)
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
    
    func testPresentShowTasks_showError_whenResultIsFailed() {
        // given
        let error = StorageError.internalError
        let result = TaskResult.failure(error)
        let response = TaskDataFlow.ShowTasks.Response(result: result)
        // when
        presenter.presentShowTasks(response, identifier: nil)
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
    
    func testPresentTaskEditing_showEditing() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskEditing(identifier)
        // then
        XCTAssertEqual(viewMock.invokedShowEditingCount, 1)
        XCTAssertNotNil(viewMock.invokedShowEditingParameters)
    }
    
    func testPresentTaskActions_showActionSheet() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskActions(identifier)
        // then
        XCTAssertEqual(viewMock.invokedShowActionSheetCount, 1)
        XCTAssertNotNil(viewMock.invokedShowActionSheetParameters)
        XCTAssertEqual(viewMock.invokedShowActionSheetParameters?.dialog.actions.count, 3)
    }
    
    func testPresentTaskActions_showEditing_whenEditingActionIsTapped() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskActions(identifier)
        let action = viewMock.invokedShowActionSheetParameters?.dialog.actions[safe: 0]
        action?.onTap?()
        // then
        XCTAssertEqual(viewMock.invokedShowEditingCount, 1)
    }
    
    func testPresentTaskActions_deleteItem_whenDeleteActionIsTapped() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskActions(identifier)
        let action = viewMock.invokedShowActionSheetParameters?.dialog.actions[safe: 1]
        action?.onTap?()
        // then
        XCTAssertEqual(viewMock.invokedDeleteItemCount, 1)
    }
    
}
