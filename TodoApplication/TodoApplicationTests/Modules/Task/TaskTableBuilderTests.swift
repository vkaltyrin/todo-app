@testable import TodoApplication
import XCTest

final class TaskTableBuilderTests: TestCase {
    // MARK: - Tests
    func testBuilder_buildCellsWithCorrectReuseIdentifiers() {
        // given
        let items = [TestData.viewData]
        let builder = TaskTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: nil,
            onTaskTap: nil,
            onCellTextDidEndEditing: nil
        )
        
        // when
        let sections = builder.build()
        
        // then
        let cell = getCellConfigurator(sections: sections)
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.reuseIdentifier, String(describing: TaskCell.self))
    }
    
    func testBuilder_buildCell_whereOnDeleteTapReturnsCorrectIdentifier() {
        // given
        let items = [TestData.viewData]
        let identifierForDelete = items.first?.identifier
        let onDeleteTap: TaskTableBuilder.OnDeleteTap = { identifier in
            XCTAssertEqual(identifier, identifierForDelete)
        }
        
        let builder = TaskTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: onDeleteTap,
            onTaskTap: nil,
            onCellTextDidEndEditing: nil
        )
        
        // when
        let sections = builder.build()
        let cellConfigurator = getCellConfigurator(sections: sections)
        XCTAssertNotNil(cellConfigurator)
        
        // then
        let result = cellConfigurator?.call(
            action: .swipeToDelete,
            cell: nil,
            indexPath: TestData.indexPath
        )
        XCTAssertNotNil(result)
    }
    
    func testBuilder_buildCell_whereOnTaskTapReturnsCorrectValue() {
        // given
        let items = [TestData.viewData]
        let onTaskTap: TaskTableBuilder.OnTaskTap = { item in
            XCTAssertEqual(item.identifier, items.first?.identifier)
            XCTAssertEqual(item.name, items.first?.name)
        }
        
        let builder = TaskTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: nil,
            onTaskTap: onTaskTap,
            onCellTextDidEndEditing: nil
        )
        
        // when
        let sections = builder.build()
        let cellConfigurator = getCellConfigurator(sections: sections)
        XCTAssertNotNil(cellConfigurator)
        
        // then
        let result = cellConfigurator?.call(
            action: .tap,
            cell: nil,
            indexPath: TestData.indexPath
        )
        XCTAssertNotNil(result)
    }
    
    func testBuilder_buildCell_whereOnCellTextDidEndEditingReturnsCorrectValue() {
        // given
        let items = [TestData.viewData]
        let onCellTextDidEndEditing: TaskTableBuilder.OnCellTextDidEndEditing = { item in
            XCTAssertEqual(item.identifier, items.first?.identifier)
            XCTAssertEqual(item.name, items.first?.name)
        }
        
        let builder = TaskTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: nil,
            onTaskTap: nil,
            onCellTextDidEndEditing: onCellTextDidEndEditing
        )
        
        // when
        let sections = builder.build()
        let cellConfigurator = getCellConfigurator(sections: sections)
        XCTAssertNotNil(cellConfigurator)
        
        // then
        let result = cellConfigurator?.call(
            action: .configure,
            cell: nil,
            indexPath: TestData.indexPath
        )
        XCTAssertNotNil(result)
    }
}

extension TaskTableBuilderTests {
    private func getCellConfigurator(sections: [TableSection]) -> CellConfigurator? {
        let section = sections.first
        return section?.cells.first
    }
    
    struct TestData {
        static let viewData = TaskViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier()
        )
        static let indexPath = IndexPath(row: 0, section: 0)
    }
}
