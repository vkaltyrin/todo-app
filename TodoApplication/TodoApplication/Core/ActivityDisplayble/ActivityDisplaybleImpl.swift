import Foundation
import UIKit

final class ActivityDisplaybleImpl: ActivityDisplayble {

    weak var activityIndicatorView: UIActivityIndicatorView? {
        didSet {
            activityIndicatorView?.hidesWhenStopped = true
        }
    }

    init(activityIndicatorView: UIActivityIndicatorView) {
        self.activityIndicatorView = activityIndicatorView
    }

    func startActivity() {
        activityIndicatorView?.startAnimating()
    }

    func stopActivity() {
        activityIndicatorView?.stopAnimating()
    }
}
