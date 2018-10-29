import Foundation
import UIKit

final class ActivityDisplaybleImpl: ActivityDisplayble {
    // MARK: - Dependencies
    private weak var activityIndicatorView: UIActivityIndicatorView?

    // MARK: - Init
    init(activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView = activityIndicatorView
    }

    // MARK: - ActivityDisplayble
    func startActivity() {
        activityIndicatorView?.startAnimating()
    }

    func stopActivity() {
        activityIndicatorView?.stopAnimating()
    }
}
