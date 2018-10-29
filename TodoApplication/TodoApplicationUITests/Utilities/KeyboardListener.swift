import EarlGrey
import Foundation

// Swift implementation of keyboard listener from private sources of EarlGrey.

protocol KeyboardListener: class {
    func waitForKeyboardToAppear(with timeout: TimeInterval) -> Bool
}

final class KeyboardListenerImpl: KeyboardListener {

    // MARK: - Private
    private var isKeyboardShown = Atomic<Bool>(false)

    // MARK: - Init

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide(_:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notifications

    func waitForKeyboardToAppear(with timeout: TimeInterval) -> Bool {
        if isKeyboardShown.value {
            return true
        }

        let condition = GREYCondition(name: "Keyboard did appear") { () -> Bool in
            self.isKeyboardShown.value
        }

        return condition.wait(withTimeout: timeout)
    }

    // MARK: - Private

    @objc private func keyboardDidShow(_ notification: NSNotification?) {
        isKeyboardShown.value = true
    }

    @objc private func keyboardDidHide(_ notification: NSNotification?) {
        isKeyboardShown.value = false
    }

}
