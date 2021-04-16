protocol IHeroesService {
    func getHeroes(
            completionHandler: @escaping ([Hero]?, Error?) -> Void,
            loadingOffset: Int
    )
}

class HeroesService: IHeroesService {
    private let fetcher: IHeroesFetcher

    init(heroesFetcher: IHeroesFetcher) {
        fetcher = heroesFetcher
    }

    func getHeroes(
            completionHandler: @escaping ([Hero]?, Error?) -> Void,
            loadingOffset: Int
    ) {
        // fetchHeroesFromDb()

        fetchHeroesFromApi(completionHandler, loadingOffset: loadingOffset)
    }

    private func fetchHeroesFromApi(
            _ completionHandler: @escaping ([Hero]?, Error?) -> Void,
            loadingOffset: Int
    ) {
        print("<<<DEV>>> Fetch data from api with offset \(loadingOffset)")
        fetcher.fetchHeroes(completionHandler, loadingOffset: loadingOffset)
    }

    private func fetchHeroesFromDb() {
        print("<<<DEV>>> Fetch data from db")
    }
}

