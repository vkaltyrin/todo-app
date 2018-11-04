@testable import TodoApplication
import XCTest

final class TaskCellTests: TestCase {
    // MARK: - Subject under test
    var cell: TaskCell!
    
    // MARK: - Set up
    override func setUp() {
        super.setUp()
        
        cell = TaskCell.loadFromNib()
    }
    
    // MARK: - Tests
    func testConfigure_setsCorrectlyViewModel() {
        // given
        var onTextDidEndEditingCalled = false
        let viewModel = TaskViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier(),
            isDone: true,
            onSwitchTap: nil,
            onTextDidEndEditing: { _ in onTextDidEndEditingCalled = true }
        )
        
        // when
        cell.configure(viewModel)
        cell.onTextDidEndEditing?("")
        
        // then
        XCTAssertEqual(viewModel.name, cell.textField.text)
        XCTAssertEqual(viewModel.isDone, cell.switchView.isOn)
        XCTAssertTrue(onTextDidEndEditingCalled)
    }
    
    func testConfigure_setsCorrectlyOnSwitchTapCallback() {
        // given
        var onSwitchTapCalled = false
        let viewModel = TaskViewModel(
            identifier: Identifier.generateUniqueIdentifier(),
            name: Identifier.generateUniqueIdentifier(),
            isDone: true,
            onSwitchTap: { _ in onSwitchTapCalled = true },
            onTextDidEndEditing: nil
        )
        
        // when
        cell.configure(viewModel)
        cell.onValueChanged(cell.switchView)
        
        // then
        XCTAssertTrue(onSwitchTapCalled)
    }
    
    func testConfigure_setsAccessibilityIdentifierIndex() {
        // when
        cell.setAccessibilityIdentifierIndex(index: 0)
        
        // then
        XCTAssertEqual(cell.textField.qaAccessibilityIdentifier, "\(TaskDataFlow.AccessibilityIdentifiers.taskTextField)0")
    }
}

