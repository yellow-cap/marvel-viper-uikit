import UIKit

protocol IHeroesRouter: IRouter {}

class HeroesRouter: IHeroesRouter {
    enum Route: IRoute {
        case heroDetails
    }

    weak var parentController: UIViewController?

    func routeTo(to: IRoute, props: IProps?) {
        guard let to = to as? Route else {
            return
        }

        switch to {
        case .heroDetails:
            let viewController = HeroDetailsModule().build()
            parentController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
