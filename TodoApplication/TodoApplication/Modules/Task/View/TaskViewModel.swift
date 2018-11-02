import Foundation

struct TaskViewModel {
    let identifier: Identifier
    let name: String
    let isDone: Bool

    var onSwitchTap: ((Bool) -> ())?
}
