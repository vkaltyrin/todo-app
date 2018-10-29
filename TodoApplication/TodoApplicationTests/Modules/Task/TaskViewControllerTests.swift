@testable import TodoApplication
import XCTest

final class TaskViewControllerTests: TestCase {
    // MARK: - Subject Under Test
    var view: TaskViewController!
    var interactorMock: TaskInteractorMock!
    var tableDirectorMock: TaskViewTableDirectorMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        interactorMock = TaskInteractorMock()
        tableDirectorMock = TaskViewTableDirectorMock()
        
        view = TaskViewController()
        view.interactor = interactorMock
        view.tableDirector = tableDirectorMock
    }
    
    // MARK: - Tests
    func testShowEditing_callsTableDirectorToFocusOnTask() {
        // given
        let identfier = Identifier.generateUniqueIdentifier()
        // when
        view.showEditing(identfier)
        // then
        XCTAssertEqual(tableDirectorMock.invokedFocusOnCellCount, 1)
    }
    
    func testDeleteItem_callsInteractorToDeleteItem() {
        // given
        let identfier = Identifier.generateUniqueIdentifier()
        // when
        view.deleteItem(identfier)
        // then
        XCTAssertEqual(interactorMock.invokedDeleteItemCount, 1)
    }
    
    func testShowItems_fetchItems_whenStateIsLoading() {
        // given
        let viewModel = TaskDataFlow.ShowTasks.ViewModel(state: .loading)
        // when
        view.showItems(viewModel)
        // then
        XCTAssertEqual(interactorMock.invokedFetchItemsCount, 1)
    }
    
    func testShowItems_updateTableView_whenStateIsResult() {
        // given
        let item = TaskViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        let viewModel = TaskDataFlow.ShowTasks.ViewModel(state:
            .result(items: [item], identifier: nil)
        )
        // when
        view.showItems(viewModel)
        // then
        XCTAssertEqual(tableDirectorMock.invokedItemsSetterCount, 1)
    }
    
    func testShowItems_openEditing_whenStateIsResultWithIdentifier() {
        // given
        let viewModel = TaskDataFlow.ShowTasks.ViewModel(state:
            .result(items: [], identifier: Identifier.generateUniqueIdentifier())
        )
        // when
        view.showItems(viewModel)
        // then
        XCTAssertEqual(interactorMock.invokedOpenTaskEditingCount, 1)
    }
    
    func testTableDirector_deleteItem_onSwipeToDelete() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.viewDidLoad()
        tableDirectorMock.invokedOnDeleteTap?(identifier)
        // then
        XCTAssertEqual(interactorMock.invokedDeleteItemCount, 1)
    }
    
    func testTableDirector_updateItem_onKeyboardDidHide() {
        // given
        let viewModel = TaskViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        // when
        view.viewDidLoad()
        tableDirectorMock.invokedOnCellTextDidEndEditing?(viewModel)
        // then
        XCTAssertEqual(interactorMock.invokedUpdateItemCount, 1)
    }
    
    func testTableDirector_openTaskActions_onTaskTap() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.viewDidLoad()
        tableDirectorMock.invokedOnTaskTap?(identifier)
        // then
        XCTAssertEqual(interactorMock.invokedOpenTaskActionsCount, 1)
    }
    
}
