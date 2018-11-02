import Foundation

struct Task {
    let identifier: Identifier?
    let name: String
    let isDone: Bool
    let creationDate: Date

    init(name: String,
         isDone: Bool = false,
         identifier: Identifier? = nil,
         creationDate: Date = Date()) {
        self.name = name
        self.isDone = isDone
        self.identifier = identifier
        self.creationDate = creationDate
    }
}
