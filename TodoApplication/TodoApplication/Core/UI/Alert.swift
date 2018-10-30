import Foundation
import UIKit

extension Dialog.Style {
    func toUIKitStyle() -> UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        case .default:
            return .default
        }
    }
}

struct Dialog {
    enum Style {
        case `default`
        case cancel
    }

    struct Action {
        let title: String
        let style: Dialog.Style
        let onTap: (() -> ())?
    }

    let title: String?
    let message: String?
    let actions: [Action]

    init(title: String? = nil, message: String? = nil, actions: [Action] = []) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

protocol AlertDisplayable: class {
    func showAlert(_ dialog: Dialog)
}

protocol ActionSheetDisplayable: class {
    func showActionSheet(_ dialog: Dialog)
}

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
