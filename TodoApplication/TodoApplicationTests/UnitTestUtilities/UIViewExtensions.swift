@testable import TodoApplication
import XCTest

extension UIView {
    class func loadFromNib<T: UIView>() -> T?  {
        let bundle = Bundle(for: T.self)
        let name = String(describing: T.self)
        guard let viewFromNib = bundle.loadNibNamed(String(describing: name), owner: self)?.first as? T else {
            XCTFail("\(name) nib did not contain a UIView")
            return nil
        }
        return viewFromNib
    }
}
