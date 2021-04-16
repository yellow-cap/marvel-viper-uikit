import RealmSwift

class DbStorage: IDbStorage {
    init() {
        print("<<<DEV>> Realm db file url \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
    }

    func insert(dbEntity: Object) throws {
        let db = try Realm()
        do {
            try db.write {
                db.add(dbEntity)
            }
        } catch {
            throw DbError(message: "Couldn't insert to db", error: error)
        }
    }

    func findAll(dbEntityType: Object.Type) throws -> Results<Object> {
        let db = try Realm()
        return db.objects(dbEntityType)
    }
}
