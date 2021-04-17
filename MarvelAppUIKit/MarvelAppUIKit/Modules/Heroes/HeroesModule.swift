import UIKit

class HeroesModule: IModule {
    func build() -> UIViewController {
        let view = HeroesView()
        let interaction = HeroesInteraction(
                heroesService: HeroesService(
                        heroesFetcher: HeroesFetcher(apiFetcher: ApiFetcher()),
                        dbStorage: try! DbStorage()
                ),
                imageFetcher: ImageFetcher()
        )
        let presenter = HeroesPresenter()
        let router = HeroesRouter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view
        presenter.router = router

        router.parentController = view

        interaction.presenter = presenter

        return view
    }
}
