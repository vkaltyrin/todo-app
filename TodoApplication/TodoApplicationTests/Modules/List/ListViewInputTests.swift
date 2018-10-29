@testable import TodoApplication
import XCTest

final class ListViewInputTests: TestCase {
    // MARK: - Subject Under Test
    var view: ListViewInput!
    var interactorMock: ListInteractorMock!
    var routerMock: ListRouterMock!
    var tableDirectorMock: ListViewTableDirectorMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        interactorMock = ListInteractorMock()
        routerMock = ListRouterMock()
        tableDirectorMock = ListViewTableDirectorMock()
        
        let viewController = ListViewController()
        viewController.interactor = interactorMock
        viewController.router = routerMock
        viewController.tableDirector = tableDirectorMock
        
        view = viewController
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
}
