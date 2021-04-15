protocol IHeroesInteraction: IInteraction {
    var presenter: IHeroesPresenter? { get set }
    func getHeroes()
}

class HeroesInteraction: IHeroesInteraction {
    weak var presenter: IHeroesPresenter?
    private let heroesService: IHeroesService

    init(heroesService: IHeroesService) {
        self.heroesService = heroesService
    }

    func getHeroes() {
        heroesService.getHeroes()
    }
}