import UIKit

protocol IHeroesView: IView {
    var presenter: IHeroesPresenter? { get set }
}

class HeroesView: UIViewController, IHeroesView {
    var presenter: IHeroesPresenter?

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
        print("<<<DEV>>> Heroes view did load")
    }
}
