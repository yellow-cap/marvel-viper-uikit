import UIKit

protocol IHeroDetailsView: IView {
    var presenter: IHeroDetailsPresenter? { get set }
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
    }

    func update(_ newProps: IViewProps) {
        print("update Hero Details")
    }

    private func initView() {
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32.0, weight: .regular)
        label.text = "Hero Details View"
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
