import Foundation
import RealmSwift

final class TestStorageUtilityImpl: TestStorageUtility {
    init() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TestStorage"
    }
    
    func resetState() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
