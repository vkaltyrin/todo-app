import Foundation
import RealmSwift

final class RealmTask: Object {
    @objc dynamic var identifier: Identifier = ""
    @objc dynamic var name = ""
    @objc dynamic var isDone = false
    @objc dynamic var creationDate = Date()
    let owner = LinkingObjects(fromType: RealmList.self, property: "tasks")
}

extension RealmTask {
    func toTask() -> Task {
        return Task(
            name: name,
            isDone: isDone,
            identifier: identifier,
            creationDate: creationDate
        )
    }
}

extension Array where Element == Task {
    func toRealm() -> [RealmTask] {
        return map { $0.toRealm() }
    }
}

extension Task {
    func toRealm() -> RealmTask {
        let result = RealmTask()
        result.identifier = identifier ?? Identifier.generateUniqueIdentifier()
        result.name = name
        result.isDone = isDone
        result.creationDate = creationDate
        return result
    }
}
