import Foundation

struct TaskViewModel {
    let identifier: Identifier
    let name: String
    let isDone: Bool
    let onSwitchTap: ((Bool) -> ())?
}
