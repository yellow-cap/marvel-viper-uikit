
protocol IHeroDetailsInteraction: IInteraction {
    var presenter: IHeroDetailsPresenter? { get set }
    func getHero()
}

class HeroDetailsInteraction: IHeroDetailsInteraction {
    private let hero: Hero
    weak var presenter: IHeroDetailsPresenter?

    init(hero: Hero) {
        self.hero = hero
    }

    func getHero() {
        presenter?.updateView(hero: hero)
    }
}