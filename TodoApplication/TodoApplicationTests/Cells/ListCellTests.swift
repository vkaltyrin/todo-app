@testable import TodoApplication
import XCTest

final class ListCellTests: TestCase {
    // MARK: - Subject under test
    var cell: ListCell!
    
    // MARK: - Set up
    override func setUp() {
        super.setUp()
        
        cell = ListCell.loadFromNib()
    }
    
    // MARK: - Tests
    func testConfigure_setsCorrectlyViewModel() {
        // given
        var onTextDidEndEditingCalled = false
        let viewModel = ListViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier(),
            onTextDidEndEditing: { _ in onTextDidEndEditingCalled = true }
        )
        // when
        
        
        cell.configure(viewModel)
        cell.onTextDidEndEditing?("")
        
        // then
        XCTAssertEqual(viewModel.name, cell.textField.text)
        XCTAssertTrue(onTextDidEndEditingCalled)
    }
    
    func testConfigure_setsAccessibilityIdentifierIndex() {
        // when
        cell.setAccessibilityIdentifierIndex(index: 0)
        
        // then
        XCTAssertEqual(cell.textField.qaAccessibilityIdentifier, "\(ListDataFlow.AccessibilityIdentifiers.listTextField)0")
    }
}

