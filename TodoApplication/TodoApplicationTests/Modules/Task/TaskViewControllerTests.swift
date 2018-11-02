@testable import TodoApplication
import XCTest

final class TaskViewControllerTests: TestCase {
    // MARK: - Subject Under Test
    var view: TaskViewController!
    var interactorMock: TaskInteractorMock!
    var tableManagerMock: TableManagerMock<CellConfigurator>!
    var activityDisplayableMock: ActivityDisplayableMock!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        
        interactorMock = TaskInteractorMock()
        tableManagerMock = TableManagerMock<CellConfigurator>()
        activityDisplayableMock = ActivityDisplayableMock()
        
        view = TaskViewController()
        view.interactor = interactorMock
        view.tableManager = tableManagerMock
        view.activityDisplayable = activityDisplayableMock
    }
    
    // MARK: - Tests
    func testView_callsInteractorToFetchItems_onViewDidLoad() {
        // when
        view.viewDidLoad()
        // then
        XCTAssertEqual(interactorMock.invokedFetchItemsCount, 1)
    }
    
    func testShowEditing_callsInteractorToOpenTaskEditing() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        // when
        view.showEditing(identifier)
        // then
        XCTAssertEqual(interactorMock.invokedOpenTaskEditingCount, 1)
        XCTAssertEqual(interactorMock.invokedOpenTaskEditingParameters?.request.identifier, identifier)
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
    
    func testSelectItem_callsInteractorToOpenTaskActions() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.selectItem(identifier, name: name)
        // then
        XCTAssertEqual(interactorMock.invokedOpenTaskActionsCount, 1)
        XCTAssertEqual(interactorMock.invokedOpenTaskActionsParameters?.request.identifier, identifier)
    }
    
    func testUpdateItem_callsInteractorToUpdateItemName() {
        // given
        let identifier = Identifier.generateUniqueIdentifier()
        let name = Identifier.generateUniqueIdentifier()
        // when
        view.updateItem(identifier, name: name)
        // then
        XCTAssertEqual(interactorMock.invokedUpdateItemNameCount, 1)
        XCTAssertEqual(interactorMock.invokedUpdateItemNameParameters?.request.identifier, identifier)
        XCTAssertEqual(interactorMock.invokedUpdateItemNameParameters?.request.name, name)
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
    
    func testStartActivity_startsActivityWithActivityDisplayable() {
        // when
        view.startActivity()
        // then
        XCTAssertEqual(activityDisplayableMock.invokedStartActivityCount, 1)
    }
    
    func testStopActivity_stopsActivityWithActivityDisplayable() {
        // when
        view.stopActivity()
        // then
        XCTAssertEqual(activityDisplayableMock.invokedStopActivityCount, 1)
    }
}

extension TaskViewControllerTests {
    struct TestData {
        static let viewModel = TaskViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        static let sections = [TableSection(cells: [TableCell<TaskCell>(viewModel: TestData.viewModel)])]
    }
}
