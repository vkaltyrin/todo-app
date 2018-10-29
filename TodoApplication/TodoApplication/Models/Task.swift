import Foundation

struct Task {
    let identifier: Identifier?
    let name: String
    let creationDate: Date

    init(name: String,
         identifier: Identifier? = nil,
         creationDate: Date = Date()) {
        self.name = name
        self.identifier = identifier
        self.creationDate = creationDate
    }
}
