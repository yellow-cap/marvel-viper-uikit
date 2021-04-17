import UIKit

protocol IHeroesView: IView {
    var presenter: IHeroesPresenter? { get set }
}

struct HeroesViewProps: IProps {
    let heroes: [Hero]
    let loadAvatar: (URL, @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    let cancelAvatarLoading: (UUID) -> Void
    let routeToDetails: (Hero) -> Void
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
        getHeroes()
    }

    func update(_ newProps: IProps) {
        guard let props = newProps as? HeroesViewProps else {
            return
        }

        heroesCollectionView.update(HeroesCollectionViewProps(
                heroes: props.heroes,
                loadHeroes: getHeroes,
                loadAvatar: props.loadAvatar,
                cancelAvatarLoading: props.cancelAvatarLoading,
                routeToDetails: props.routeToDetails
        ))
    }

    private func placeView() {
        view.addSubview(heroesCollectionView)

        NSLayoutConstraint.activate([
            heroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            heroesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func getHeroes() {
        guard let presenter = presenter else {
            return
        }

        presenter.getHeroes()
    }
}
