protocol IHeroesPresenter: IPresenter {
    var interaction: IHeroesInteraction? { get set }
    var view: IHeroesView? { get set }
}

class HeroesPresenter: IHeroesPresenter {
    var interaction: IHeroesInteraction?
    weak var view: IHeroesView?
}