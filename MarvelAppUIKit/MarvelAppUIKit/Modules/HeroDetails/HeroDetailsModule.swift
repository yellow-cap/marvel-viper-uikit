import UIKit

class HeroDetailsModule: IModule {

    func build() -> UIViewController {
        let view = HeroDetailsView()

        let interaction = HeroDetailsInteraction()
        let presenter = HeroDetailsPresenter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view

        interaction.presenter = presenter

        return view
    }
}
