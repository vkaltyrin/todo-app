import EarlGrey
import Foundation

final class TestUtils {
    
    private static let timeout = TimeInterval(10)

    class func waitForKeyboardToAppear() -> Bool {
        return KeyboardListenerImpl().waitForKeyboardToAppear(with: timeout)
    }

    class func back() {
        EarlGrey.selectElement(with: grey_accessibilityID("BackButton"))
            .perform(grey_tap())
    }
    
    class func retrieveText(accessibilityIdentifier: String, onText: ((String) -> ())?) {
        EarlGrey.selectElement(with: grey_accessibilityID(accessibilityIdentifier))
            .perform(grey_getText(onText: onText))
    }
    
}
