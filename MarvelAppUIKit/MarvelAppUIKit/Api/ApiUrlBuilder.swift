class ApiUrlBuilder {
    private static let marvelApiBaseUrl = "https://gateway.marvel.com:443/v1/public"

    public static func getHeroesUrl() -> String {
        "\(marvelApiBaseUrl)/characters"
    }
}