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
        let loadingOffset = heroes.count

        heroesService.getHeroes(
                completionHandler: onGetHeroesComplete,
                loadingOffset: loadingOffset
        )
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

        DispatchQueue.main.async { [weak self] in
            self?.heroes.append(contentsOf: heroes)
            self?.presenter?.updateView(heroes: self?.heroes ?? [])
        }
    }
}