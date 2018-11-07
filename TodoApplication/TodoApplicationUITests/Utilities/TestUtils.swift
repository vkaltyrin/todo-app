import EarlGrey
import Foundation

final class TestUtils {
    
    private static let timeout = TimeInterval(10)

    class func back() {
        EarlGrey.selectElement(with: grey_accessibilityID("BackButton"))
            .perform(grey_tap())
    }
    
}
