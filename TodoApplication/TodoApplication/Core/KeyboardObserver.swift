import Foundation
import UIKit

protocol KeyboardObserver: class {
    var onKeyboardWillShown: ((CGRect) -> ())? { get set }
    var onKeyboardWillHide: (() -> ())? { get set }
}

final class KeyboardObserverImpl: KeyboardObserver {

    private var keyboardFrameEnd: NSValue?

    // MARK: - KeyboardFrameObserver
    var onKeyboardWillShown: ((CGRect) -> ())?
    var onKeyboardWillHide: (() -> ())?

    // MARK: - Init
    init() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShown(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShown(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifications
    @objc private func keyboardWillShown(_ notification: NSNotification?) {
        guard keyboardFrameEnd == nil
            else { return }

        let userInfo = notification?.userInfo
        self.keyboardFrameEnd = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue

        guard let frameValue = self.keyboardFrameEnd
            else { return }

        onKeyboardWillShown?(frameValue.cgRectValue)
    }

    @objc private func keyboardWillHide(_ notification: NSNotification?) {
        onKeyboardWillHide?()
    }

}
