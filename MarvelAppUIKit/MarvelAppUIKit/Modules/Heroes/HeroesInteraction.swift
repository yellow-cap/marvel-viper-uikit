import Foundation

protocol IHeroesInteraction: IInteraction {
    var presenter: IHeroesPresenter? { get set }
    func getHeroes()
}

class HeroesInteraction: IHeroesInteraction {
    weak var presenter: IHeroesPresenter?
    private let heroesService: IHeroesService

    private var heroes = [Hero]()

    init(heroesService: IHeroesService) {
        self.heroesService = heroesService
    }

    func getHeroes() {
        heroesService.getHeroes(completionHandler: onGetHeroesComplete)
    }

    func onGetHeroesComplete(heroes: [Hero]?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)

            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.heroes.append(contentsOf: heroes!)
            print(self?.heroes)
            self?.presenter?.updateHeroesList()
        }
    }
}