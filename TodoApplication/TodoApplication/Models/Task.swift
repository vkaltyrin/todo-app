import Foundation

struct Task {
    @objc enum Status: Int {
        case undone
        case done
    }

    let identifier: Identifier?
    let name: String
    let status: Status
    let creationDate: Date
}
