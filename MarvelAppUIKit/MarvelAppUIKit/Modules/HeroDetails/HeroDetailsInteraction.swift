
protocol IHeroDetailsInteraction: IInteraction {
    var presenter: IHeroDetailsPresenter? { get set }
}

class HeroDetailsInteraction: IHeroDetailsInteraction {
    weak var presenter: IHeroDetailsPresenter?
}