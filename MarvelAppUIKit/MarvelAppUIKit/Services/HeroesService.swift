protocol IHeroesService {
    var delegate: HeroesServiceDelegate? { get set }
    func getHeroes(loadingOffset: Int)
}

protocol HeroesServiceDelegate {
    func onGetHeroesComplete(heroes: [Hero]?, error: Error?)
}

class HeroesService: IHeroesService {
    var delegate: HeroesServiceDelegate?
    private let fetcher: IHeroesFetcher
    private let dbStorage: IDbStorage


    init(heroesFetcher: IHeroesFetcher, dbStorage: IDbStorage) {
        fetcher = heroesFetcher
        self.dbStorage = dbStorage
    }

    func getHeroes(loadingOffset: Int) {
        // fetchHeroesFromDb()

        fetchHeroesFromApi(loadingOffset: loadingOffset)
    }

    private func fetchHeroesFromApi(loadingOffset: Int) {
        print("<<<DEV>>> Fetch data from api with offset \(loadingOffset)")
        fetcher.fetchHeroes(onFetchHeroesFromApiComplete, loadingOffset: loadingOffset)
    }

    private func onFetchHeroesFromApiComplete(heroes: [Hero]?, error: Error?) {
        delegate?.onGetHeroesComplete(heroes: heroes, error: error)
    }

    private func fetchHeroesFromDb() {
        print("<<<DEV>>> Fetch data from db")
    }
}

