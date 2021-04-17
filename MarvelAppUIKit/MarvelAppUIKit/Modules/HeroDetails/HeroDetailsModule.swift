import UIKit

struct HeroDetailsModuleProps: IProps {
    let hero: Hero
}

class HeroDetailsModule: IModule {
    func build(_ props: IProps? = nil) -> UIViewController {

        guard let props = props as? HeroDetailsModuleProps else {
            return UIViewController()
        }

        let view = HeroDetailsView()

        let interaction = HeroDetailsInteraction(hero: props.hero)
        let presenter = HeroDetailsPresenter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view

        interaction.presenter = presenter

        return view
    }
}
