import UIKit

protocol IHeroesView: IView {
    var presenter: IHeroesPresenter? { get set }
}

class HeroesView: UIViewController, IHeroesView {
    var presenter: IHeroesPresenter?
    private var heroesCollectionView = HeroesCollectionView(frame: .zero)

    override func loadView() {
        super.loadView()

        placeView()
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        print("<<<DEV>>> Heroes view did load")
        presenter?.viewDidLoad()
    }

    private func placeView() {
        view.addSubview(heroesCollectionView)

        NSLayoutConstraint.activate([
            heroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            heroesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heroesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
