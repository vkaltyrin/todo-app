import Foundation
import UIKit

final class ActivityDisplayableImpl: ActivityDisplayable {
    // MARK: - Dependencies
    private weak var activityIndicatorView: UIActivityIndicatorView?

    // MARK: - Init
    init(activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView = activityIndicatorView
    }

    // MARK: - ActivityDisplayable
    func startActivity() {
        activityIndicatorView?.startAnimating()
    }

    func stopActivity() {
        activityIndicatorView?.stopAnimating()
    }
}
