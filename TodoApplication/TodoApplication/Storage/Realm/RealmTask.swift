import Foundation
import RealmSwift

final class RealmTask: Object {
    @objc dynamic var identifier: Identifier?
    @objc dynamic var name = ""
    @objc dynamic var status = Task.Status.undone
    @objc dynamic var creationDate = Date()
}

extension RealmTask {
    func toTask() -> Task {
        return Task(
            identifier: identifier,
            name: name,
            status: status,
            creationDate: creationDate
        )
    }
}

extension Task {
    func toRealm() -> RealmTask {
        let result = RealmTask()
        result.identifier = identifier
        result.name = name
        result.status = status
        result.creationDate = creationDate
        return result
    }
}
