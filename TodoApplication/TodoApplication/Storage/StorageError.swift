import Foundation

enum StorageError {
    case cannotCreate
    case cannotFetch
    case cannotDelete
    case cannotUpdate

    // Error to handle exceptions in database.
    // It's not a regular case by the way.
    case internalError
}
