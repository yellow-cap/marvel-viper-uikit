import UIKit

protocol IHeroDetailsView: IView {
    var presenter: IHeroDetailsPresenter? { get set }
}

struct HeroDetailsViewProps: IProps {
    let hero: Hero
}

class HeroDetailsView: UIViewController, IHeroDetailsView {
    private enum SegmentedControlSections: Int {
        case comics = 0
        case stories = 1
        case events = 2
        case series = 3
    }

    var presenter: IHeroDetailsPresenter?

    private let label: UILabel = UILabel()
    private let segmentedControl = UISegmentedControl()
    private var selectedSegmentIndex: Int = 0

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

        setupSegmentedControl()
    }

    private func placeView() {
        view.addSubview(label)
        view.addSubview(segmentedControl)

        label.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupSegmentedControl() {
        segmentedControl.insertSegment(withTitle: "Comics", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Stories", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Events", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Series", at: 3, animated: false)

        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        segmentedControl.addTarget(self, action: #selector(onSegmentChange), for: .valueChanged)
    }
    
    @objc private func onSegmentChange(sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex

        print("Segment selected: \(selectedSegmentIndex)")
    }
}
