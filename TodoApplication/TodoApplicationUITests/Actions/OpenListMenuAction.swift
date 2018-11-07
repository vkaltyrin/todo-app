import EarlGrey
import Foundation
import XCTest
@testable import TodoApplication

final class OpenListMenuAction: BaseTestAction {
    
    private let row: UInt
    
    init(row: UInt) {
        self.row = row
    }
    
    override func perform() {
        EarlGrey.selectElement(with: matcherFactory.cell())
            .atIndex(row)
            .perform(grey_tap())
    }
}
