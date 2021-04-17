protocol IHeroDetailsPresenter: IPresenter {
    var interaction: IHeroDetailsInteraction? { get set }
    var view: IHeroDetailsView? { get set }
    func getHero()
    func updateView(hero: Hero)
}

class HeroDetailsPresenter: IHeroDetailsPresenter {
    var interaction: IHeroDetailsInteraction?
    weak var view: IHeroDetailsView?

    func updateView(hero: Hero) {
        view?.update(HeroDetailsViewProps(hero: hero))
    }

    func getHero() {
        interaction?.getHero()
    }
}