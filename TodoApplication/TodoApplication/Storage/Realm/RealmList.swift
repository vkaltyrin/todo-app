import Foundation
import RealmSwift

final class RealmList: Object {
    @objc dynamic var identifier: Identifier?
    @objc dynamic var name = ""
    let tasks = RealmSwift.List<RealmTask>()
}

extension RealmList {
    func toList() -> List {
        return List(
            identifier: identifier,
            name: name,
            tasks: tasks.map { $0.toTask() }
        )
    }
}

extension List {
    func toRealm() -> RealmList {
        let result = RealmList()
        result.identifier = identifier
        result.name = name

        let realm = try? Realm()
        realm?.beginWrite()
        result.tasks.append(objectsIn: tasks.map { $0.toRealm() })
        try? realm?.commitWrite()

        return result
    }
}
