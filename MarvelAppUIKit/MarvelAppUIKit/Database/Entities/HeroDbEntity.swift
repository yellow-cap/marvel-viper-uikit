import RealmSwift

class HeroDbEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var thumbnail: HeroThumbnailDbEntity?
    @objc dynamic var comics: HeroDetailsItemDbEntity?
    @objc dynamic var series: HeroDetailsItemDbEntity?
    @objc dynamic var stories: HeroDetailsItemDbEntity?
    @objc dynamic var events: HeroDetailsItemDbEntity?
}