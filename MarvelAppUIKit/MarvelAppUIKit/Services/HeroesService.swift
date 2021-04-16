import Foundation

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
        if let error = error {
            delegate?.onGetHeroesComplete(heroes: nil, error: error)
            return
        }

        guard let heroes = heroes else {
            return
        }

        saveHeroesToDb(heroes)
        delegate?.onGetHeroesComplete(heroes: heroes, error: nil)
    }

    private func saveHeroesToDb(_ heroes: [Hero]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            for hero in heroes {
                let heroDbEntity = HeroDbEntity()
                heroDbEntity.id = hero.id
                heroDbEntity.name = hero.name
                heroDbEntity.desc = hero.description

                do {
                    try self?.dbStorage.insert(dbEntity: heroDbEntity)
                } catch {
                    DispatchQueue.main.async {
                        self?.delegate?.onGetHeroesComplete(heroes: nil, error: error)
                    }
                }
            }
        }
    }

    private func fetchHeroesFromDb() {
        print("<<<DEV>>> Fetch data from db")
    }
}

