import UIKit

class HeroesModule: IModule {
    func build() -> UIViewController {
        let view = HeroesView()
        let interaction = HeroesInteraction()
        let presenter = HeroesPresenter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view

        interaction.presenter = presenter

        return view
    }
}
