import Foundation

struct Task {
    enum Status {
        case undone
        case done
    }

    let identifier: Identifier?
    let name: String
    let status: Status
    let creationDate: Date
}
