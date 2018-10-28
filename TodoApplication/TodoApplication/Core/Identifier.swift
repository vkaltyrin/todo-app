import Foundation

typealias Identifier = String

extension Identifier {
    static func generateUniqueIdentifier() -> Identifier {
        return NSUUID().uuidString
    }
}
