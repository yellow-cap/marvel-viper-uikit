import UIKit

protocol IHeroDetailsView: IView {
    var presenter: IHeroDetailsPresenter? { get set }
}

struct HeroDetailsViewProps: IProps {
    let hero: Hero
}

class HeroDetailsView: UIViewController, IHeroDetailsView {
    var presenter: IHeroDetailsPresenter?

    private let label: UILabel = UILabel()

    override func loadView() {
        super.loadView()
        initView()
        placeView()
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        presenter?.getHero()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    func update(_ newProps: IProps) {
        guard let props = newProps as? HeroDetailsViewProps else {
            return
        }
        title = props.hero.name
        label.text = "\(props.hero.id)"
    }

    private func initView() {
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32.0, weight: .regular)
    }

    private func placeView() {
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
