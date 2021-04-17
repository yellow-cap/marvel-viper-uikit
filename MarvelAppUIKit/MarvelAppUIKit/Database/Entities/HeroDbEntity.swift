import RealmSwift

class HeroDbEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var thumbnail: HeroThumbnailDbEntity?
}