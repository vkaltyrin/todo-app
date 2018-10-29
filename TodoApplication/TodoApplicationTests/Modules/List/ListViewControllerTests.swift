@testable import TodoApplication
import XCTest

final class ListViewControllerTests: TestCase {
    // MARK: - Subject Under Test
    var view: ListViewController!
    var interactorMock: ListInteractorMock!
    var routerMock: ListRouterMock!
    var tableDirectorMock: ListViewTableDirectorMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        interactorMock = ListInteractorMock()
        routerMock = ListRouterMock()
        tableDirectorMock = ListViewTableDirectorMock()
        
        view = ListViewController()
        view.interactor = interactorMock
        view.router = routerMock
        view.tableDirector = tableDirectorMock
    }
    
    // MARK: - Tests
    func testShowEditing_callsTableDirectorToFocusOnList() {
        // given
        let identfier = Identifier.generateUniqueIdentifier()
        // when
        view.showEditing(identfier)
        // then
        XCTAssertEqual(tableDirectorMock.invokedFocusOnListCount, 1)
    }
    
    func testDeleteItem_callsInteractorToDeleteItem() {
        // given
        let identfier = Identifier.generateUniqueIdentifier()
        // when
        view.deleteItem(identfier)
        // then
        XCTAssertEqual(interactorMock.invokedDeleteItemCount, 1)
    }
    
    func testOpenTasks_callsRouterToOpenTasks() {
        // given
        let identfier = Identifier.generateUniqueIdentifier()
        // when
        view.openTasks(identfier)
        // then
        XCTAssertEqual(routerMock.invokedOpenTasksCount, 1)
    }
    
    func testShowItems_fetchItems_whenStateIsLoading() {
        // given
        let viewModel = ListDataFlow.ShowLists.ViewModel(state: .loading)
        // when
        view.showItems(viewModel)
        // then
        XCTAssertEqual(interactorMock.invokedFetchItemsCount, 1)
    }
    
    func testShowItems_updateTableView_whenStateIsResult() {
        // given
        let item = ListViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        let viewModel = ListDataFlow.ShowLists.ViewModel(state:
            .result(items: [item], listIdentifier: nil)
        )
        // when
        view.showItems(viewModel)
        // then
        XCTAssertEqual(tableDirectorMock.invokedItemsSetterCount, 1)
    }
    
    func testShowItems_openEditing_whenStateIsResultWithIdentifier() {
        // given
        let viewModel = ListDataFlow.ShowLists.ViewModel(state:
            .result(items: [], listIdentifier: Identifier.generateUniqueIdentifier())
        )
        // when
        view.showItems(viewModel)
        // then
        XCTAssertEqual(interactorMock.invokedOpenListEditingCount, 1)
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
        let identifier = Identifier.generateUniqueIdentifier()
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.viewDidLoad()
        tableDirectorMock.invokedOnCellTextDidEndEditing?(identifier, name)
        // then
        XCTAssertEqual(interactorMock.invokedUpdateItemCount, 1)
    }
    
    func testTableDirector_openListActions_onListTap() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.viewDidLoad()
        tableDirectorMock.invokedOnListTap?(identifier)
        // then
        XCTAssertEqual(interactorMock.invokedOpenListActionsCount, 1)
    }
    
}
