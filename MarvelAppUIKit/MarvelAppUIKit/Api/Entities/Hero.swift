struct Hero: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: HeroThumbnail
    let comics: HeroDetailsItem
    let series: HeroDetailsItem
    let stories: HeroDetailsItem
    let events: HeroDetailsItem
}
