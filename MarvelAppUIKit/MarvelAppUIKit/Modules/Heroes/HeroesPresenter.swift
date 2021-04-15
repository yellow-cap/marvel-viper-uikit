protocol IHeroesPresenter: IPresenter {
    var interaction: IHeroesInteraction? { get set }
    var view: IHeroesView? { get set }
    func getHeroes()
    func updateHeroesList()
}

class HeroesPresenter: IHeroesPresenter {
    var interaction: IHeroesInteraction?
    weak var view: IHeroesView?

    func getHeroes() {
        interaction?.getHeroes()
    }

    func updateHeroesList() {
        // view?.update(<#T##newProps: IViewProps##MarvelAppUIKit.IViewProps#>)
    }
}