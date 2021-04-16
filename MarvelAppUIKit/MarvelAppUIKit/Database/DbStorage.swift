import RealmSwift

class DbStorage: IStorage {
    private var realm: Realm? = nil

    init() throws {
        do {
            realm = try Realm()
        } catch {
            throw DbError(
                    message: "DbStorage, couldn't initialize Realm",
                    error: error
            )
        }
    }
}
