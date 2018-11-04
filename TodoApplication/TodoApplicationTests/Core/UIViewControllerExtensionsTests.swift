@testable import TodoApplication
import XCTest

final class UIViewControllerExtensionsTests: TestCase {
    // MARK: - Subject under test
    var viewController: UIViewController!
    
    // MARK: - Set Up
    override func setUp() {
        super.setUp()
        self.viewController = UIViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    // MARK: - Tests
    func testShowAlert_showsUIKitAlert() {
        // given
        let dialog = buildDialog(onFirstActionTap: nil, onSecondActionTap: nil)
        
        // when
        viewController.showAlert(dialog)
        
        // then
        testDialogIsMappedIntoUIAlertController(dialog: dialog, style: .alert)
    }
    
    func testShowActionSheet_showsUIKitActionSheet() {
        // given
        let dialog = buildDialog(onFirstActionTap: nil, onSecondActionTap: nil)
        
        // when
        viewController.showActionSheet(dialog)
        
        // then
        testDialogIsMappedIntoUIAlertController(dialog: dialog, style: .actionSheet)
    }
    
    func testShowAlert_showsAlert_withCallableActions() {
        // given
        var isFirstActionTapped = false
        var isSecondActionTapped = false
        let dialog = buildDialog(
            onFirstActionTap: {
                isFirstActionTapped = true
            },
            onSecondActionTap: {
                isSecondActionTapped = true
            }
        )
        
        // when
        viewController.showAlert(dialog)
        
        // then
        callUIAlertActions(alert: viewController.presentedViewController as? UIAlertController)
        XCTAssertTrue(isFirstActionTapped)
        XCTAssertTrue(isSecondActionTapped)
    }
    
    func testShowActionSheet_showsDialog_withCallableActions() {
        // given
        var isFirstActionTapped = false
        var isSecondActionTapped = false
        let dialog = buildDialog(
            onFirstActionTap: {
                isFirstActionTapped = true
            },
            onSecondActionTap: {
                isSecondActionTapped = true
            }
        )
        
        // when
        viewController.showActionSheet(dialog)
        
        // then
        callUIAlertActions(alert: viewController.presentedViewController as? UIAlertController)
        XCTAssertTrue(isFirstActionTapped)
        XCTAssertTrue(isSecondActionTapped)
    }
}

private extension UIViewControllerExtensionsTests {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void
    
    func performAlertAction(with action: UIAlertAction) {
        let handler = action.value(forKey: "handler")
        let blockPointer = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(handler as AnyObject).toOpaque())
        unsafeBitCast(blockPointer, to: AlertHandler.self)(action)
    }
    
    func buildDialog(onFirstActionTap: (() -> ())?, onSecondActionTap: (() -> ())?) -> Dialog {
        let actions = [
            Dialog.Action(
                title: Identifier.generateUniqueIdentifier(),
                style: .default,
                onTap: onFirstActionTap
            ),
            Dialog.Action(
                title: Identifier.generateUniqueIdentifier(),
                style: .cancel,
                onTap: onSecondActionTap
            )
        ]
        return Dialog(
            title: Identifier.generateUniqueIdentifier(),
            message: Identifier.generateUniqueIdentifier(),
            actions: actions
        )
    }
    
    func testDialogIsMappedIntoUIAlertController(dialog: Dialog, style: UIAlertController.Style) {
        let alertController = viewController.presentedViewController as? UIAlertController
        XCTAssertNotNil(alertController)
        XCTAssertEqual(alertController?.preferredStyle, style)
        XCTAssertEqual(alertController?.title, dialog.title)
        XCTAssertEqual(alertController?.message, dialog.message)
        dialog.actions.enumerated().forEach { offset, action in
            XCTAssertEqual(alertController?.actions[safe: offset]?.title, action.title)
            XCTAssertEqual(alertController?.actions[safe: offset]?.style, action.style.toUIKitStyle())
        }
    }
    
    func callUIAlertActions(alert: UIAlertController?) {
        let alertController = viewController.presentedViewController as? UIAlertController
        guard let firstAction = alertController?.actions[safe: 0] else {
            XCTFail("First action must exist")
            return
        }
        performAlertAction(with: firstAction)
        
        guard let secondAction = alertController?.actions[safe: 1] else {
            XCTFail("Second action must exist")
            return
        }
        performAlertAction(with: secondAction)
    }
}
