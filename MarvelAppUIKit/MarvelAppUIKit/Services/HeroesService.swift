protocol IHeroesService {
    func getHeroes()
}

class HeroesService: IHeroesService {
    private let fetcher: IHeroesFetcher

    init(heroesFetcher: IHeroesFetcher) {
        fetcher = heroesFetcher
    }

    func getHeroes() {
        // fetch heroes from db

        // fetch heroes from api
        fetchHeroesFromApi()
    }

    private func fetchHeroesFromApi() {
        fetcher.fetchHeroes { result in
            print("<<<DEV>>> Heroes: \(result)")
        }
    }
}

