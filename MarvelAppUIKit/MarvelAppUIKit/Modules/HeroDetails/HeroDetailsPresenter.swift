protocol IHeroDetailsPresenter: IPresenter {
    var interaction: IHeroDetailsInteraction? { get set }
    var view: IHeroDetailsView? { get set }
    func updateView()
}

class HeroDetailsPresenter: IHeroDetailsPresenter {
    var interaction: IHeroDetailsInteraction?
    weak var view: IHeroDetailsView?

    func updateView() {}
}