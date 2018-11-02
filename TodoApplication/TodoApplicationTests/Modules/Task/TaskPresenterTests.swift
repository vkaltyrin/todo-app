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
    
    func testPresenter_deleteItem_onSwipeToDelete() {
        // given
        let tasks = TestData.tasks
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        let sections = viewMock.invokedReloadTableParameters?.sections
        let cell = sections?[safe: 0]?.cells[safe: 0]
        let result = cell?.call(action: .swipeToDelete, cell: nil, indexPath: TestData.indexPath)
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(viewMock.invokedDeleteItemCount, 1)
    }
    
    func testPresenter_selectItem_onTaskTap() {
        // given
        let tasks = TestData.tasks
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        let sections = viewMock.invokedReloadTableParameters?.sections
        let cell = sections?[safe: 0]?.cells[safe: 0]
        let result = cell?.call(action: .tap, cell: nil, indexPath: TestData.indexPath)
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(viewMock.invokedSelectItemCount, 1)
    }
    
    func testPresenter_updateItemDoneness_onSwitchTap() {
        // given
        let tasks = TestData.tasks
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        let sections = viewMock.invokedReloadTableParameters?.sections
        let cell = sections?[safe: 0]?.cells[safe: 0]
        let result = cell?.call(action: .tap, cell: nil, indexPath: TestData.indexPath)
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(viewMock.invokedSelectItemCount, 1)
    }
    
    func testPresenter_doesNotAllowSelectItem_onTaskTap_forEditingState() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let tasks = [Task(name: identifier, identifier: Identifier.generateUniqueIdentifier())]
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        presenter.presentTaskEditing(identifier)
        let sections = viewMock.invokedReloadTableParameters?.sections
        let cell = sections?[safe: 0]?.cells[safe: 0]
        let result = cell?.call(action: .tap, cell: nil, indexPath: TestData.indexPath)
        // then
        XCTAssertNotNil(result)
        XCTAssertEqual(viewMock.invokedSelectItemCount, 0)
    }
    
    func testPresentShowTask_showError_forErrorResponse() {
        // given
        let response = TaskDataFlow.ShowTasks.Response(result: .failure(.internalError))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        // then
        XCTAssertEqual(viewMock.invokedShowAlertCount, 1)
        XCTAssertEqual(viewMock.invokedShowAlertParameters?.dialog.message, TestData.Text.internalError)
    }
    
    func testPresentShowTask_updateTable_forSuccessfulResponse() {
        // given
        let tasks = TestData.tasks
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        // then
        XCTAssertEqual(viewMock.invokedReloadTableCount, 1)
    }
    
    func testPresentShowTask_filterNotValidTasks_forSuccessfulResponse() {
        // given
        let tasks = TestData.notValidTasks
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        // then
        XCTAssertEqual(viewMock.invokedReloadTableParameters?.sections[safe: 0]?.cells.count, 0)
    }
    
    func testPresentShowTask_stopLoading_forSuccessfulResponse() {
        // given
        let tasks = [Task(name: Identifier.generateUniqueIdentifier())]
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: nil)
        // then
        XCTAssertEqual(viewMock.invokedStopActivityCount, 1)
    }
    
    func testPresentShowTask_focusOnCell_forSuccessfulResponse_andNonnilIdentifier() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let tasks = [Task(name: Identifier.generateUniqueIdentifier())]
        let response = TaskDataFlow.ShowTasks.Response(result: .success(tasks))
        // when
        presenter.presentShowTasks(response, identifier: identifier)
        // then
        XCTAssertEqual(viewMock.invokedFocusOnCount, 1)
        XCTAssertEqual(viewMock.invokedFocusOnParameters?.identifier, identifier)
    }
    
    func testPresentError_showError_forInternalError() {
        testPresentError_showError_forText(error: .internalError, text: TestData.Text.internalError)
    }
    
    func testPresentError_showError_forCannotCreate() {
        testPresentError_showError_forText(error: .cannotCreate, text: TestData.Text.incorrectInput)
    }
    
    func testPresentError_showError_forCannotDelete() {
        testPresentError_showError_forText(error: .cannotDelete, text: TestData.Text.incorrectInput)
    }
    
    func testPresentError_showError_forCannotUpdate() {
        testPresentError_showError_forText(error: .cannotUpdate, text: TestData.Text.incorrectInput)
    }
    
    func testPresentError_showError_forCannotFetch() {
        testPresentError_showError_forText(error: .cannotFetch, text: TestData.Text.incorrectInput)
    }
    
    func testPresentLoading_startLoading() {
        // when
        presenter.presentLoading()
        // then
        XCTAssertEqual(viewMock.invokedStartActivityCount, 1)
    }
    
    func testPresentTaskEditing_focusOnCell() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskEditing(identifier)
        // then
        XCTAssertEqual(viewMock.invokedFocusOnCount, 1)
        XCTAssertEqual(viewMock.invokedFocusOnParameters?.identifier, identifier)
    }
    
    func testPresentTaskEditing_stopLoading() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskEditing(identifier)
        // then
        XCTAssertEqual(viewMock.invokedStopActivityCount, 1)
    }
    
    func testPresentTaskActions_showActionSheet() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskActions(identifier)
        // then
        XCTAssertEqual(viewMock.invokedShowActionSheetCount, 1)
        XCTAssertNotNil(viewMock.invokedShowActionSheetParameters)
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
    
    func testPresentTaskActions_buildDialog() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        presenter.presentTaskActions(identifier)
        // then
        let dialog = viewMock.invokedShowActionSheetParameters?.dialog
        XCTAssertEqual(dialog?.actions.count, 3)
        XCTAssertEqual(dialog?.actions[safe: 0]?.title, TestData.Text.editTask)
        XCTAssertEqual(dialog?.actions[safe: 1]?.title, TestData.Text.deleteTask)
        XCTAssertEqual(dialog?.actions[safe: 2]?.title, TestData.Text.cancel)
    }
    
    // MARK: - Private
    
    private func testPresentError_showError_forText(error: StorageError, text: String) {
        // when
        presenter.presentError(error)
        // then
        XCTAssertEqual(viewMock.invokedShowAlertCount, 1)
        
        let dialog = viewMock.invokedShowAlertParameters?.dialog
        XCTAssertEqual(dialog?.actions.count, 1)
        XCTAssertEqual(dialog?.actions[safe: 0]?.title, TestData.Text.ok)
        XCTAssertEqual(dialog?.message, text)
    }
    
}

extension TaskPresenterTests {
    struct TestData {
        struct Text {
            static let incorrectInput = "Incorrect input in the database 🤔"
            static let internalError = "Internal error 😕 Please try again!"
            static let editTask = "Edit todo 📝"
            static let deleteTask = "Delete 🗑"
            static let lookAtTasks = "Look at tasks ▶️"
            static let cancel = "Cancel"
            static let ok = "OK"
        }
        static let indexPath = IndexPath(row: 0, section: 0)
        static let tasks = [
            Task(name: Identifier.generateUniqueIdentifier(), identifier: Identifier.generateUniqueIdentifier())
        ]
        static let notValidTasks = [
            Task(name: Identifier.generateUniqueIdentifier())
        ]
    }
}
