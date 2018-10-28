@testable import TodoApplication

extension Task: Equatable {}

public func ==(lhs: Task, rhs: Task) -> Bool {
    return lhs.identifier == rhs.identifier
        && lhs.name == rhs.name
        && lhs.status == rhs.status
        && lhs.creationDate == rhs.creationDate
}
