import Foundation

struct List {
    let name: String
    let tasks: [Task]
    let identifier: Identifier?

    init(name: String, tasks: [Task] = [], identifier: Identifier? = nil) {
        self.name = name
        self.tasks = tasks
        self.identifier = identifier
    }
}
