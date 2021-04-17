import UIKit

protocol IHeroesView: IView {
    var presenter: IHeroesPresenter? { get set }
}

struct HeroesViewProps: IViewProps {
    let heroes: [Hero]
    let loadAvatar: (URL, @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    let cancelAvatarLoading: (UUID) -> Void
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

    func update(_ newProps: IViewProps) {
        guard let props = newProps as? HeroesViewProps else {
            return
        }

        heroesCollectionView.update(HeroesCollectionViewProps(
                heroes: props.heroes,
                loadHeroes: getHeroes,
                loadAvatar: props.loadAvatar,
                cancelAvatarLoading: props.cancelAvatarLoading
        ))
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

    private func getHeroes() {
        guard let presenter = presenter else {
            return
        }

        presenter.getHeroes()
    }
}
