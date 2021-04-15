import UIKit

class HeroesModule: IModule {
    func build() -> UIViewController {
        let view = HeroesView()
        let interaction = HeroesInteraction(
                heroesService: HeroesService(
                        heroesFetcher: HeroesFetcher(apiFetcher: ApiFetcher())
                )
        )
        let presenter = HeroesPresenter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view

        interaction.presenter = presenter

        return view
    }
}