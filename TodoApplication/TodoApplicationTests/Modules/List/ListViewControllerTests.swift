@testable import TodoApplication
import XCTest

final class ListViewControllerTests: TestCase {
    // MARK: - Subject Under Test
    var view: ListViewController!
    var interactorMock: ListInteractorMock!
    var routerMock: ListRouterMock!
    var tableManagerMock: TableManagerMock<CellConfigurator>!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        interactorMock = ListInteractorMock()
        routerMock = ListRouterMock()
        tableManagerMock = TableManagerMock<CellConfigurator>()
        
        view = ListViewController()
        view.interactor = interactorMock
        view.router = routerMock
        view.tableManager = tableManagerMock
    }
    
    // MARK: - Tests
    func testShowEditing_callsInteractorToOpenListEditing() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.showEditing(identifier)
        // then
        XCTAssertEqual(interactorMock.invokedOpenListEditingCount, 1)
        XCTAssertEqual(interactorMock.invokedOpenListEditingParameters?.request.identifier, identifier)
    }
    
    func testDeleteItem_callsInteractorToDeleteItem() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.deleteItem(identifier)
        // then
        XCTAssertEqual(interactorMock.invokedDeleteItemCount, 1)
        XCTAssertEqual(interactorMock.invokedDeleteItemParameters?.request.identifier, identifier)
    }
    
    func testOpenTasks_callsRouterToOpenTasks() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.openTasks(identifier, name: name)
        // then
        XCTAssertEqual(routerMock.invokedOpenTasksCount, 1)
    }
    
    func testSelectItem_callsInteractorToOpenListActions() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.selectItem(identifier, name: name)
        // then
        XCTAssertEqual(interactorMock.invokedOpenListActionsCount, 1)
        XCTAssertEqual(interactorMock.invokedOpenListActionsParameters?.request.identifier, identifier)
        XCTAssertEqual(interactorMock.invokedOpenListActionsParameters?.request.name, name)
    }
    
    func testUpdateItem_callsInteractorToUpdateItem() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.updateItem(identifier, name: name)
        // then
        XCTAssertEqual(interactorMock.invokedUpdateItemCount, 1)
        XCTAssertEqual(interactorMock.invokedUpdateItemParameters?.request.identifier, identifier)
        XCTAssertEqual(interactorMock.invokedUpdateItemParameters?.request.name, name)
    }
    
    func testReloadTable_callsTableManagerReload() {
        // given
        let sections = TestData.sections
        // when
        view.reloadTable(sections)
        // then
        XCTAssertEqual(tableManagerMock.invokedReloadCount, 1)
    }
    
    func testFetchItem_callsInteractorToFetchAllItems() {
        // when
        view.fetchItems()
        // then
        XCTAssertEqual(interactorMock.invokedFetchItemsCount, 1)
    }
    
    func testFocusOn_callsTableManagerFocusOnWithFirstSection() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.focusOn(identifier)
        // then
        XCTAssertEqual(tableManagerMock.invokedFocusOnCount, 1)
        XCTAssertEqual(tableManagerMock.invokedFocusOnParameters?.sectionIndex, 0)
    }
    
    func testCreateTask_callsInteractorToCreateItem() {
        // given
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.createItem(name: name)
        // then
        XCTAssertEqual(interactorMock.invokedCreateItemCount, 1)
        XCTAssertEqual(interactorMock.invokedCreateItemParameters?.request.name, name)
    }
}

extension ListViewControllerTests {
    struct TestData {
        static let viewModel = ListViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        static let sections = [TableSection(cells: [TableCell<ListCell>(viewModel: TestData.viewModel)])]
    }
}
