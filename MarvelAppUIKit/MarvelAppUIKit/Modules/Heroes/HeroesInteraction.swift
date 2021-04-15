protocol IHeroesInteraction: IInteraction {
    var presenter: IHeroesPresenter? { get set }
}

class HeroesInteraction: IHeroesInteraction {
    weak var presenter: IHeroesPresenter?
}