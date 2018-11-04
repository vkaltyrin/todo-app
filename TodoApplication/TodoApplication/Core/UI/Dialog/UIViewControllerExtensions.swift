import Foundation
import UIKit

extension UIViewController: AlertDisplayable, ActionSheetDisplayable {

    func showActionSheet(_ dialog: Dialog) {
        showDialog(dialog, style: .actionSheet)
    }

    func showAlert(_ dialog: Dialog) {
        showDialog(dialog, style: .alert)
    }

    // MARK: - Private

    private func showDialog(_ dialog: Dialog, style: UIAlertController.Style) {
        let alert = UIAlertController(
            title: dialog.title,
            message: dialog.message,
            preferredStyle: style
        )

        dialog.actions.forEach { dialog in
            let handler: (UIAlertAction) -> () = { _ in dialog.onTap?() }
            let action = UIAlertAction(
                title: dialog.title,
                style: dialog.style.toUIKitStyle(),
                handler: handler
            )
            alert.addAction(action)
        }

        present(alert, animated: true, completion: nil)
    }
}
