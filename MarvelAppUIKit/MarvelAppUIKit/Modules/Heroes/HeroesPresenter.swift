protocol IHeroesPresenter: IPresenter {
    var interaction: IHeroesInteraction? { get set }
    var view: IHeroesView? { get set }
    func viewDidLoad()
    func updateHeroesList()
}

class HeroesPresenter: IHeroesPresenter {
    var interaction: IHeroesInteraction?
    weak var view: IHeroesView?

    func viewDidLoad() {
        interaction?.getHeroes()
    }

    func updateHeroesList() {

    }
}