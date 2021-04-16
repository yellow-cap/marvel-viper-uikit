import RealmSwift

protocol IDbStorage {
    func insert(dbEntity: Object) throws
    func findAll(dbEntityType: Object.Type) throws -> Results<Object>
}

