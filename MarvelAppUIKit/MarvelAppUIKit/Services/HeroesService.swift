protocol IHeroesService {
    func getHeroes(completionHandler: @escaping ([Hero]?, Error?) -> Void)
}

class HeroesService: IHeroesService {
    private let fetcher: IHeroesFetcher

    init(heroesFetcher: IHeroesFetcher) {
        fetcher = heroesFetcher
    }

    func getHeroes(completionHandler: @escaping ([Hero]?, Error?) -> Void) {
        // fetchHeroesFromDb()

        fetchHeroesFromApi(completionHandler)
    }

    private func fetchHeroesFromApi(_ completionHandler: @escaping ([Hero]?, Error?) -> Void) {
        print("<<<DEV>>> Fetch data from api")

        fetcher.fetchHeroes { heroes, error in
            completionHandler(heroes, error)
        }
    }

    private func fetchHeroesFromDb() {
        print("<<<DEV>>> Fetch data from db")
    }
}

