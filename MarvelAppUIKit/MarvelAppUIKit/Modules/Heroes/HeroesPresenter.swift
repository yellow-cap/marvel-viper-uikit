protocol IHeroesPresenter: IPresenter {
    var interaction: IHeroesInteraction? { get set }
    var router: IHeroesRouter? { get set }
    var view: IHeroesView? { get set }
    func getHeroes()
    func updateView(heroes: [Hero])
}

class HeroesPresenter: IHeroesPresenter {
    var interaction: IHeroesInteraction?
    var router: IHeroesRouter?
    weak var view: IHeroesView?

    func getHeroes() {
        interaction?.getHeroes()
    }

    func updateView(heroes: [Hero]) {
        guard let interaction = interaction else {
            return
        }

        view?.update(
                HeroesViewProps(
                        heroes: heroes,
                        loadAvatar: interaction.loadImage,
                        cancelAvatarLoading: interaction.cancelLoadingTask,
                        routeToDetails: { hero in
                            self.router?.routeTo(to: HeroesRouter.Route.heroDetails, props: nil)
                        }
                )
        )
    }
}