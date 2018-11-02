@testable import TodoApplication
import XCTest

final class ListTableBuilderTests: TestCase {
    // MARK: - Tests
    func testBuilder_buildCellsWithCorrectReuseIdentifiers() {
        // given
        let items = [TestData.viewData]
        let builder = ListTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: nil,
            onListTap: nil
        )
        
        // when
        let sections = builder.build()
        
        // then
        let cell = getCellConfigurator(sections: sections)
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.reuseIdentifier, String(describing: ListCell.self))
    }
    
    func testBuilder_buildCell_whereOnDeleteTapReturnsCorrectIdentifier() {
        // given
        let items = [TestData.viewData]
        let identifierForDelete = items.first?.identifier
        let onDeleteTap: ListTableBuilder.OnDeleteTap = { identifier in
            XCTAssertEqual(identifier, identifierForDelete)
        }
        
        let builder = ListTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: onDeleteTap,
            onListTap: nil
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
    
    func testBuilder_buildCell_whereOnListTapReturnsCorrectValue() {
        // given
        let items = [TestData.viewData]
        let onListTap: ListTableBuilder.OnListTap = { item in
            XCTAssertEqual(item.identifier, items.first?.identifier)
            XCTAssertEqual(item.name, items.first?.name)
        }
        
        let builder = ListTableBuilder(
            items: items,
            focusIdentifier: nil,
            onDeleteTap: nil,
            onListTap: onListTap
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
}

extension ListTableBuilderTests {
    private func getCellConfigurator(sections: [TableSection]) -> CellConfigurator? {
        let section = sections.first
        return section?.cells.first
    }
    
    struct TestData {
        static let viewData = ListViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier(),
            onTextDidEndEditing: nil
        )
        static let indexPath = IndexPath(row: 0, section: 0)
    }
}
