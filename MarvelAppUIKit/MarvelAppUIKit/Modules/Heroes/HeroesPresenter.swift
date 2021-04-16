protocol IHeroesPresenter: IPresenter {
    var interaction: IHeroesInteraction? { get set }
    var view: IHeroesView? { get set }
    func getHeroes()
    func updateView(heroes: [Hero])
}

class HeroesPresenter: IHeroesPresenter {
    var interaction: IHeroesInteraction?
    weak var view: IHeroesView?

    func getHeroes() {
        interaction?.getHeroes()
    }

    func updateView(heroes: [Hero]) {
        view?.update(HeroesViewProps(heroes: heroes))
    }
}