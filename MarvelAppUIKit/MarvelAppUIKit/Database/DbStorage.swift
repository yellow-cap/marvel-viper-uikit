import RealmSwift

class DbStorage: IDbStorage {
    func insert(dbEntity: Object) throws {
        let db = try! Realm()
        do {
            try db.write {
                db.add(dbEntity)
            }
        } catch {
            throw DbError(message: "Couldn't insert to db", error: error)
        }
    }
}
