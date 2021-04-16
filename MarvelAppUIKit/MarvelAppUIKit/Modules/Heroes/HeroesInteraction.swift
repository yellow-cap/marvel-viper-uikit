import Foundation

protocol IHeroesInteraction: IInteraction {
    var presenter: IHeroesPresenter? { get set }
    func getHeroes()
}

class HeroesInteraction: IHeroesInteraction, HeroesServiceDelegate {
    weak var presenter: IHeroesPresenter?
    private var heroesService: IHeroesService

    private var heroes = [Hero]()

    init(heroesService: IHeroesService) {
        self.heroesService = heroesService
        self.heroesService.delegate = self
    }

    func getHeroes() {
        let loadingOffset = heroes.count

        heroesService.getHeroes(loadingOffset: loadingOffset)
    }

    func onGetHeroesComplete(heroes: [Hero]?, error: Error?) {
        if let error = error {
            // presenter show error

            return
        }

        guard let heroes = heroes else {
            // presenter show error
            return
        }

        self.heroes.append(contentsOf: heroes)
        presenter?.updateView(heroes: self.heroes)
    }
}