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
    private let batchSize = 20

    init(heroesFetcher: IHeroesFetcher, dbStorage: IDbStorage) {
        fetcher = heroesFetcher
        self.dbStorage = dbStorage
    }

    func getHeroes(loadingOffset: Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let semaphore = DispatchSemaphore(value: 0)

            var heroes = [Hero]()
            DispatchQueue.global(qos: .background).async {
                print("<<<DEV>>> HeroesService: Try to fetch data from db with offset \(loadingOffset)")
                heroes = self?.fetchHeroesFromDb(loadingOffset) ?? []
                semaphore.signal()
            }

            semaphore.wait()

            if heroes.isEmpty {
                print("<<<DEV>>> HeroesService: Try to fetch data from api with offset \(loadingOffset)")
                self?.fetchHeroesFromApi(loadingOffset)
            } else {
                DispatchQueue.main.async {
                    print("<<<DEV>>> HeroesService: Data fetched from db with offset \(loadingOffset)")
                    self?.delegate?.onGetHeroesComplete(heroes: heroes, error: nil)
                }
            }
        }
    }

    private func fetchHeroesFromApi(_ loadingOffset: Int) {
        fetcher.fetchHeroes(
                onFetchHeroesFromApiComplete,
                loadingOffset: loadingOffset,
                batchSize: batchSize)
    }

    private func onFetchHeroesFromApiComplete(heroes: [Hero]?, error: Error?) {
        if let error = error {
            delegate?.onGetHeroesComplete(heroes: nil, error: error)
            return
        }

        guard let heroes = heroes else {
            return
        }

        print("<<<DEV>>> HeroesService: New batch fetched from api.")
        saveHeroesToDb(heroes)
        delegate?.onGetHeroesComplete(heroes: heroes, error: nil)
    }

    private func saveHeroesToDb(_ heroes: [Hero]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            for hero in heroes {
                let heroDbEntity = HeroServiceHelper.buildHeroDbEntityFromEntity(hero)

                do {
                    try self?.dbStorage.insert(dbEntity: heroDbEntity)
                } catch {
                    DispatchQueue.main.async {
                        self?.delegate?.onGetHeroesComplete(heroes: nil, error: error)
                    }
                }
            }
        }

        print("<<<DEV>>> HeroesService: New batch saved to db.")
    }

    private func fetchHeroesFromDb(_ loadingOffset: Int) -> [Hero] {
        var heroes = [Hero]()
        do {
            let dbHeroes = try dbStorage.findAll(dbEntityType: HeroDbEntity.self)
            dbHeroes.forEach { obj in
                guard let object = obj as? HeroDbEntity else {
                    return
                }

                heroes.append(
                        HeroServiceHelper.buildHeroEntityFromDbEntity(object)
                )
            }

        } catch {
            delegate?.onGetHeroesComplete(heroes: nil, error: error)
        }

        return heroes.range(fromIndex: loadingOffset, toIndex: loadingOffset + batchSize)
    }
}

