import RealmSwift

protocol IDbStorage {
    func insert(dbEntity: Object) throws
}

