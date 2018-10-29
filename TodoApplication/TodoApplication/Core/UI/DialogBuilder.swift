import Foundation

final class DialogBuilder {
    func build(storageError: StorageError) -> Dialog {
        let message: String
        switch storageError {
        case .internalError:
            message = "Internal error 😕 Please try again!"
        case .cannotCreate,
             .cannotDelete,
             .cannotFetch,
             .cannotUpdate:
            message = "Incorrect input in the database 🤔"
        }

        let action = Dialog.Action(
            title: "OK",
            style: .cancel,
            onTap: nil
        )
        let dialog = Dialog(
            title: nil,
            message: message,
            actions: [action]
        )
        return dialog
    }
}
