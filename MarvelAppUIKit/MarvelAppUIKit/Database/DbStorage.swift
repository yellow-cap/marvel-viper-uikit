import RealmSwift

class DbStorage: IDbStorage {
    private var db: Realm? = nil

    init() throws {
        do {
            db = try Realm()
        } catch {
            throw DbError(
                    message: "DbStorage, couldn't initialize Realm",
                    error: error
            )
        }
    }

    func insert(dbEntity: Object) throws {
        guard let db = db else {
            throw DbError(message: "DbStorage, db is nil", error: nil)
        }

        do {
            try db.write {
                db.add(dbEntity)
            }
        } catch {
            throw DbError(message: "Couldn't insert to db", error: error)
        }
    }
}
