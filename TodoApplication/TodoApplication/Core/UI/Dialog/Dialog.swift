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
