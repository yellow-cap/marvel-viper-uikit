import Foundation

class HeroServiceHelper {
    static func buildHeroDbEntityFromEntity(_ hero: Hero) -> HeroDbEntity {
        let heroDbEntity = HeroDbEntity()
        heroDbEntity.id = hero.id
        heroDbEntity.name = hero.name
        heroDbEntity.desc = hero.description

        let heroThumbDbEntity = HeroThumbnailDbEntity()
        heroThumbDbEntity.path = hero.thumbnail.path
        heroThumbDbEntity.extension = hero.thumbnail.extension

        heroDbEntity.thumbnail = heroThumbDbEntity
        heroDbEntity.comics = buildHeroDetailsItemDbEntityFromEntity(hero.comics)
        heroDbEntity.series = buildHeroDetailsItemDbEntityFromEntity(hero.series)
        heroDbEntity.stories = buildHeroDetailsItemDbEntityFromEntity(hero.stories)
        heroDbEntity.events = buildHeroDetailsItemDbEntityFromEntity(hero.events)

        return heroDbEntity
    }

    static func buildHeroEntityFromDbEntity(_ heroDbEntity: HeroDbEntity) -> Hero {
        Hero(
                id: heroDbEntity.id,
                name: heroDbEntity.name,
                description: heroDbEntity.desc,
                thumbnail: HeroThumbnail(
                        path: heroDbEntity.thumbnail?.path ?? "",
                        extension: heroDbEntity.thumbnail?.extension ?? ""),
                comics: buildHeroDetailsItemEntityFromDbEntity(heroDbEntity.comics),
                series: buildHeroDetailsItemEntityFromDbEntity(heroDbEntity.series),
                stories: buildHeroDetailsItemEntityFromDbEntity(heroDbEntity.stories),
                events: buildHeroDetailsItemEntityFromDbEntity(heroDbEntity.events)
        )
    }

    private static func buildHeroDetailsItemEntityFromDbEntity(_ dbItem: HeroDetailsItemDbEntity?) -> HeroDetailsItem {
        guard let dbItem = dbItem else {
            return HeroDetailsItem(items: [])
        }

        return HeroDetailsItem(items: dbItem.items.map { dbSubItem in
            HeroDetailsSubItem(resourceURI: dbSubItem.resourceURI, name: dbSubItem.name)
        })
    }

    private static func buildHeroDetailsItemDbEntityFromEntity(_ item: HeroDetailsItem) -> HeroDetailsItemDbEntity {
        let heroDetailsItemDbEntity = HeroDetailsItemDbEntity()

        item.items.forEach { subItem in
            let dbSubItem = HeroDetailsSubItemDbEntity()
            dbSubItem.resourceURI = subItem.resourceURI
            dbSubItem.name = subItem.name

            heroDetailsItemDbEntity.items.append(dbSubItem)
        }

        return heroDetailsItemDbEntity
    }
}
