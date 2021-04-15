protocol IHeroesService {
    func getHeroes()
}

class HeroesService: IHeroesService {
    private let fetcher: IHeroesFetcher

    init(heroesFetcher: IHeroesFetcher) {
        fetcher = heroesFetcher
    }

    func getHeroes() {
        // fetchHeroesFromDb()

        fetchHeroesFromApi()
    }

    private func fetchHeroesFromApi() {
        print("<<DEV>> Fetch data from api")
/*        fetcher.fetchHeroes { result in
            print("<<<DEV>>> Heroes: \(result)")
        }*/
    }

    private func fetchHeroesFromDb() {
        print("<<DEV>> Fetch data from db")
    }
}

